/******************************************************************************
 * Copyright 2018 The Apollo Authors. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *****************************************************************************/

#include <gtest/gtest.h>
#include <unistd.h>
#include <atomic>
#include <string>

#include "cyber/record/file/record_file_base.h"
#include "cyber/record/file/record_file_reader.h"
#include "cyber/record/file/record_file_writer.h"
#include "cyber/record/header_builder.h"

namespace apollo {
namespace cyber {
namespace record {

const char CHAN_1[] = "/test1";
const char CHAN_2[] = "/test2";
const char MSG_TYPE[] = "apollo.cyber.proto.Test";
const char STR_10B[] = "1234567890";
const char TEST_FILE[] = "test.record";

TEST(ChunkTest, TestAll) {
  Chunk* ck = new Chunk();
  ASSERT_EQ(0, ck->header_.begin_time());
  ASSERT_EQ(0, ck->header_.end_time());
  ASSERT_EQ(0, ck->header_.raw_size());
  ASSERT_EQ(0, ck->header_.message_number());
  ASSERT_TRUE(ck->empty());

  SingleMessage msg1;
  msg1.set_channel_name(CHAN_1);
  msg1.set_content(STR_10B);
  msg1.set_time(1e9);

  ck->add(msg1);
  ASSERT_EQ(1e9, ck->header_.begin_time());
  ASSERT_EQ(1e9, ck->header_.end_time());
  ASSERT_EQ(10, ck->header_.raw_size());
  ASSERT_EQ(1, ck->header_.message_number());
  ASSERT_FALSE(ck->empty());

  SingleMessage msg2;
  msg2.set_channel_name(CHAN_2);
  msg2.set_content(STR_10B);
  msg2.set_time(2e9);

  ck->add(msg2);
  ASSERT_EQ(1e9, ck->header_.begin_time());
  ASSERT_EQ(2e9, ck->header_.end_time());
  ASSERT_EQ(20, ck->header_.raw_size());
  ASSERT_EQ(2, ck->header_.message_number());
  ASSERT_FALSE(ck->empty());

  ck->clear();
  ASSERT_EQ(0, ck->header_.begin_time());
  ASSERT_EQ(0, ck->header_.end_time());
  ASSERT_EQ(0, ck->header_.raw_size());
  ASSERT_EQ(0, ck->header_.message_number());
  ASSERT_TRUE(ck->empty());
}

TEST(RecordFileTest, TestOneMessageFile) {
  // writer open one message file
  RecordFileWriter* rfw = new RecordFileWriter();
  ASSERT_TRUE(rfw->Open(TEST_FILE));
  ASSERT_EQ(TEST_FILE, rfw->GetPath());

  // write header section
  Header hdr1 = HeaderBuilder::GetHeaderWithSegmentParams(0, 0);
  hdr1.set_chunk_interval(0);
  hdr1.set_chunk_raw_size(0);
  ASSERT_TRUE(rfw->WriteHeader(hdr1));
  ASSERT_FALSE(rfw->GetHeader().is_complete());

  // write channel section
  Channel chan1;
  chan1.set_name(CHAN_1);
  chan1.set_message_type(MSG_TYPE);
  chan1.set_proto_desc(STR_10B);
  ASSERT_TRUE(rfw->WriteChannel(chan1));

  // write chunk section
  SingleMessage msg1;
  msg1.set_channel_name(chan1.name());
  msg1.set_content(STR_10B);
  msg1.set_time(1e9);
  ASSERT_TRUE(rfw->WriteMessage(msg1));
  ASSERT_EQ(1, rfw->GetMessageNumber(chan1.name()));

  // writer close one message file
  rfw->Close();
  ASSERT_TRUE(rfw->GetHeader().is_complete());
  ASSERT_EQ(1, rfw->GetHeader().chunk_number());
  ASSERT_EQ(1e9, rfw->GetHeader().begin_time());
  ASSERT_EQ(1e9, rfw->GetHeader().end_time());
  ASSERT_EQ(1, rfw->GetHeader().message_number());
  hdr1 = rfw->GetHeader();
  delete rfw;

  // header open one message file
  RecordFileReader* rfr = new RecordFileReader();
  ASSERT_TRUE(rfr->Open(TEST_FILE));
  ASSERT_EQ(TEST_FILE, rfr->GetPath());

  Section sec;

  // read header section
  Header hdr2 = rfr->GetHeader();
  ASSERT_EQ(hdr2.chunk_number(), hdr1.chunk_number());
  ASSERT_EQ(hdr2.begin_time(), hdr1.begin_time());
  ASSERT_EQ(hdr2.end_time(), hdr1.end_time());
  ASSERT_EQ(hdr2.message_number(), hdr1.message_number());

  // read channel section
  ASSERT_TRUE(rfr->ReadSection(&sec));
  ASSERT_EQ(SectionType::SECTION_CHANNEL, sec.type);
  Channel chan2;
  ASSERT_TRUE(rfr->ReadSection<Channel>(sec.size, &chan2));
  ASSERT_EQ(chan2.name(), chan1.name());
  ASSERT_EQ(chan2.message_type(), chan1.message_type());
  ASSERT_EQ(chan2.proto_desc(), chan1.proto_desc());

  // read chunk header section
  ASSERT_TRUE(rfr->ReadSection(&sec));
  ASSERT_EQ(SectionType::SECTION_CHUNK_HEADER, sec.type);
  ChunkHeader ckh2;
  ASSERT_TRUE(rfr->ReadSection<ChunkHeader>(sec.size, &ckh2));
  ASSERT_EQ(ckh2.begin_time(), 1e9);
  ASSERT_EQ(ckh2.end_time(), 1e9);
  ASSERT_EQ(ckh2.raw_size(), 10);
  ASSERT_EQ(ckh2.message_number(), 1);

  // read chunk body section
  ASSERT_TRUE(rfr->ReadSection(&sec));
  ASSERT_EQ(SectionType::SECTION_CHUNK_BODY, sec.type);
  ChunkBody ckb2;
  ASSERT_TRUE(rfr->ReadSection<ChunkBody>(sec.size, &ckb2));
  ASSERT_EQ(ckb2.messages_size(), 1);
  ASSERT_EQ(ckb2.messages(0).channel_name(), ckb2.messages(0).channel_name());
  ASSERT_EQ(ckb2.messages(0).time(), ckb2.messages(0).time());
  ASSERT_EQ(ckb2.messages(0).content(), ckb2.messages(0).content());

  // close recorder file reader
  delete rfr;
}

TEST(RecordFileTest, TestOneChunkFile) {
  RecordFileWriter* rfw = new RecordFileWriter();

  ASSERT_TRUE(rfw->Open(TEST_FILE));
  ASSERT_EQ(TEST_FILE, rfw->GetPath());

  Header header = HeaderBuilder::GetHeaderWithChunkParams(0, 0);
  header.set_segment_interval(0);
  header.set_segment_raw_size(0);
  ASSERT_TRUE(rfw->WriteHeader(header));
  ASSERT_FALSE(rfw->GetHeader().is_complete());

  Channel chan1;
  chan1.set_name(CHAN_1);
  chan1.set_message_type(MSG_TYPE);
  chan1.set_proto_desc(STR_10B);
  ASSERT_TRUE(rfw->WriteChannel(chan1));

  Channel chan2;
  chan2.set_name(CHAN_2);
  chan2.set_message_type(MSG_TYPE);
  chan2.set_proto_desc(STR_10B);
  ASSERT_TRUE(rfw->WriteChannel(chan2));

  SingleMessage msg1;
  msg1.set_channel_name(chan1.name());
  msg1.set_content(STR_10B);
  msg1.set_time(1e9);
  ASSERT_TRUE(rfw->WriteMessage(msg1));
  ASSERT_EQ(1, rfw->GetMessageNumber(chan1.name()));

  SingleMessage msg2;
  msg2.set_channel_name(chan2.name());
  msg2.set_content(STR_10B);
  msg2.set_time(2e9);
  ASSERT_TRUE(rfw->WriteMessage(msg2));
  ASSERT_EQ(1, rfw->GetMessageNumber(chan2.name()));

  SingleMessage msg3;
  msg3.set_channel_name(chan1.name());
  msg3.set_content(STR_10B);
  msg3.set_time(3e9);
  ASSERT_TRUE(rfw->WriteMessage(msg3));
  ASSERT_EQ(2, rfw->GetMessageNumber(chan1.name()));

  rfw->Close();
  ASSERT_TRUE(rfw->GetHeader().is_complete());
  ASSERT_EQ(1, rfw->GetHeader().chunk_number());
  ASSERT_EQ(1e9, rfw->GetHeader().begin_time());
  ASSERT_EQ(3e9, rfw->GetHeader().end_time());
  ASSERT_EQ(3, rfw->GetHeader().message_number());
}

}  // namespace record
}  // namespace cyber
}  // namespace apollo

int main(int argc, char** argv) {
  testing::GTEST_FLAG(catch_exceptions) = 1;
  testing::InitGoogleTest(&argc, argv);
  google::InitGoogleLogging(argv[0]);
  FLAGS_logtostderr = true;
  return RUN_ALL_TESTS();
}
