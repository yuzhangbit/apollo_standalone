# apollo_standalone [![Build Status](https://travis-ci.com/yuzhangbit/apollo_standalone.svg?token=Jmj6MSYSGZmX9ePjdawa&branch=master)](https://travis-ci.com/yuzhangbit/apollo_standalone)

**Tested OS: ubuntu 16.04 LTS**

This is a cmake version of the Apollo5.0 release. The project structure is much more clear and simpler than our previous work – [port_apollo](https://github.com/yuzhangbit/port_apollo).  Every `CMakelists.txt` file corresponds to a `bazel` `BUILD` file in the same folder.  

## Dependencies

* protobuf(3.3.0)
* gflags(2.2.0), glog(0.3.5)
* qpOASES(master)
* osqp(0.4.1)
* curlpp(dev)
* tinyxml2(master)
* proj4(4.9.3)
* ipopt(3.12.11)
* adol-c(2.6.3)
* Eigen(dev)
* Cuda(optional, 9.0)

Some of these libraries may have already been installed to your system. You still need to run the `install_dependencies.sh` to reinstall them, since apollo `include` directories in the source codes are different from the standard ones. 


## Installation
```bash
git clone --recursive git@github.com:yuzhangbit/apollo_standalone.git
cd apollo_standalone
## install all the dependencies
bash scripts/install_dependencies.sh
```
## Build
```
mkdir -p src/apollo/build && cd src/apollo/build
cmake ..
make -j$(nproc)
sudo make install
```
All the test binary and library targets, config files and testdata will be installed to `/apollo`. 

If you have followed the [instruction](https://yuzhangbit.github.io/tools/nvidia-driver-and-cuda9-installation/) and installed the `cuda`, you can enable cuda by

```bash
mkdir -p src/apollo/build && cd src/apollo/build
cmake -DENABLE_CUDA=ON ..
make -j$(nproc)
sudo make install
```

## Run Tests 

```bash
bash run_all_test.bash
```

Since apollo tests need to load test data in `/apollo` directory to run, you have to do `sudo make install` first.

## Example
We provide a simple [example](./src/apollo/modules/planning/open_space/examples/open_space_demo.cpp) for open_space planner, here is the result.
![d](./src/apollo/modules/planning/open_space/examples/parking.png)

**NOTE**: Not all the modules of apollo have been converted to cmake projects. We only convert codes related to `open space planners` under `apollo/modules/planning` directory.  But by referring to our CMakeLists examples, you can convert interested apollo modules to cmake projects with ease.  Below is the current converting status of apollo_standalone.

* `apollo/cyber` (partial, only logging functions are enabled)
* `apollo/modules/common`  (done)
* `apollo/modules/planning`  (most of the functions are enabled)
* `apollo/modules/xxx` (only proto interfaces are enabled)

