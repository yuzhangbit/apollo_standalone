//
// Created by yangt on 2019/9/14.
//
//#include <opencv2/opencv.hpp>

#include "modules/planning/open_space/coarse_trajectory_generator/hybrid_a_star.h"
#include "modules/planning/open_space/trajectory_smoother/distance_approach_problem.h"
#include "modules/planning/open_space/trajectory_smoother/dual_variable_warm_start_problem.h"
#include "cyber/common/file.h"
#include "matplotlibcpp.hpp"

using namespace apollo;
typedef common::math::Vec2d Vec2d;

//void plotCv(const planning::HybridAStartResult &coarse_traj,
//            const Eigen::MatrixXd &smooth_traj,
//            const std::vector<std::vector<Vec2d>> &obs_list,
//            const std::vector<double> &map_bounds) {
//    int horizon = coarse_traj.x.size() - 1;
//    double r = 0.01;
//    int rows = (map_bounds.at(3) - map_bounds.at(2)) / r;
//    int cols = (map_bounds.at(1) - map_bounds.at(0)) / r;
//    cv::Mat img(rows, cols, CV_8UC3, cv::Scalar(255, 255, 255));
//    for (size_t i(0); i < obs_list.size(); ++i) {
//        const auto &obs = obs_list.at(i);
//        std::vector<cv::Point> pts(obs.size());
//        for (size_t j(0); j < obs.size(); ++j) {
//            pts[j] = cv::Point((obs.at(j).x() - map_bounds.at(0)) / r,
//                               (obs.at(j).y() - map_bounds.at(2)) / r);
//        }
//        cv::polylines(img, pts, true, cv::Scalar(0, 0, 0));
//    }
//    for (int i = 0; i < horizon; ++i) {
//        // coarse path:
//        cv::Point p1((coarse_traj.x.at(i) - map_bounds.at(0)) / r,
//                     (coarse_traj.y.at(i) - map_bounds.at(2)) / r);
//
//        cv::Point p2((coarse_traj.x.at(i + 1) - map_bounds.at(0)) / r,
//                     (coarse_traj.y.at(i + 1) - map_bounds.at(2)) / r);
//        cv::line(img, p1, p2, cv::Scalar(255, 0, 0));
//        // smooth path:
//        cv::Point p3((state(0, i) - map_bounds.at(0)) / r,
//                     (state(1, i) - map_bounds.at(2)) / r);
//
//        cv::Point p4((state(0, i + 1) - map_bounds.at(0)) / r,
//                     (state(1, i + 1) - map_bounds.at(2)) / r);
//        cv::line(img, p3, p4, cv::Scalar(255, 255, 0));
//    }
//    cv::namedWindow("result", 0);
//    cv::imshow("result", img);
//    cv::waitKey();
//}

void plotPython(const planning::HybridAStartResult &coarse_traj,
                const Eigen::MatrixXd &smooth_traj,
                const std::vector<std::vector<Vec2d>> &obs_list) {
    namespace plt = matplotlibcpp;
    plt::figure(1);
//    plt::figure_size(1200, 1200);
    // obstacle
    for (int i = 0; i < obs_list.size(); ++i) {
        const auto &obs = obs_list.at(i);
        std::vector<double> obs_x;
        std::vector<double> obs_y;
        for (const auto &pt:obs) {
            obs_x.push_back(pt.x());
            obs_y.push_back(pt.y());
        }
        obs_x.push_back(obs.front().x());
        obs_y.push_back(obs.front().y());
        plt::plot(obs_x, obs_y, "black");
    }
    // path
    std::vector<double> smooth_x;
    std::vector<double> smooth_y;
    for (size_t i(0); i < coarse_traj.x.size(); ++i) {
        smooth_x.push_back(smooth_traj(0, i));
        smooth_y.push_back(smooth_traj(1, i));
    }

    plt::plot(coarse_traj.x, coarse_traj.y, "blue", smooth_x, smooth_y, "red");
//    plt::show();
    plt::axis("equal");

    plt::figure(2);
    std::vector<double> phi, vel, t;
    for (int i = 0; i < coarse_traj.x.size(); ++i) {
        phi.push_back(smooth_traj(2, i));
        vel.push_back(smooth_traj(3, i));
        t.push_back(i);
    }
    plt::plot(t, phi, "red");
    plt::show();
}


int main(int argc, char *argv[]) {
    FLAGS_stderrthreshold = 0;
    FLAGS_v = 10;
    FLAGS_planner_open_space_config_filename =
        "/apollo/modules/planning/testdata/conf/"
        "open_space_standard_parking_lot.pb.txt";
    auto vehicle_param =
        common::VehicleConfigHelper::GetConfig().vehicle_param();

    planning::PlannerOpenSpaceConfig config;
    cyber::common::GetProtoFromFile(
        FLAGS_planner_open_space_config_filename, &config);

    /// set scene:
    std::vector<Vec2d> obs1 =
        {common::math::Vec2d(15, 30),
         common::math::Vec2d(10, 30),
         common::math::Vec2d(10, 10),
         common::math::Vec2d(15, 10)};
    std::vector<Vec2d> obs2 =
        {common::math::Vec2d(23, 30),
         common::math::Vec2d(19, 30),
         common::math::Vec2d(19, 10),
         common::math::Vec2d(23, 10)};
    std::vector<std::vector<Vec2d>> obs_list = {obs1, obs2};
    Eigen::MatrixXi obs_edge_num(obs_list.size(), 1);
    for (size_t i(0); i < obs_list.size(); ++i) {
        obs_edge_num(i, 0) = obs_list.at(i).size();
    }
    printf("total edge nums: %d\n", obs_edge_num.sum());
    Eigen::MatrixXd obsA(obs_edge_num.sum(), 2);
    Eigen::MatrixXd obsb(obs_edge_num.sum(), 1);
    obsA << 1, 0,
        0, 1,
        -1, 0,
        0, -1,
        1, 0,
        0, 1,
        -1, 0,
        0, -1;
    obsb << obs1[0].x(), obs1[1].y(), -obs1[2].x(), -obs1[3].y(),
        obs2[0].x(), obs2[1].y(), -obs2[2].x(), -obs2[3].y();
    std::cout << "obsA \n" << obsA << "\n" << "obsb: \n" << obsb << "\n";
    std::vector<double> map_bounds = {-10, 50, -10, 50};

    /// Hybrid Astar search a coarse path:
    planning::HybridAStar hybrid_aster(config);
    planning::HybridAStartResult coarse_traj;

    bool flag = hybrid_aster.Plan(0,
                                  0,
                                  0,
                                  17,
                                  20,
                                  -M_PI_2,
                                  map_bounds,
                                  obs_list,
                                  &coarse_traj);
    if (!flag) {
        printf("hybrid astar failed!!!\n");
        return 1;
    }

    /// trajectory smoothing:
    // 1. get initial guess for state and control
    int horizon = coarse_traj.x.size() - 1;
    Eigen::MatrixXd xws(horizon + 1, 4), uws(horizon, 2);
    for (size_t i(0); i < horizon + 1; ++i) {
        xws(i, 0) = coarse_traj.x.at(i);
        xws(i, 1) = coarse_traj.y.at(i);
        xws(i, 2) = coarse_traj.phi.at(i);
        xws(i, 3) = coarse_traj.v.at(i);
        if (i < horizon) {
            uws(i, 0) = coarse_traj.steer.at(i);
            uws(i, 1) = coarse_traj.a.at(i);
        }
    }

    // 2. get initial guess for dual variables /lamda and /miu
    Eigen::MatrixXd ego(4, 1);
    ego << 0, 0, vehicle_param.length(), vehicle_param.width();

    Eigen::MatrixXd lamda_ws;
    Eigen::MatrixXd miu_ws;
    double ts = 1;
    planning::DualVariableWarmStartProblem dual_var_problem(config);
    flag = dual_var_problem.Solve(horizon,
                                  ts,
                                  ego,
                                  obs_list.size(),
                                  obs_edge_num,
                                  obsA,
                                  obsb,
                                  xws.transpose(),
                                  &lamda_ws,
                                  &miu_ws);
    printf(" lamda size: %d, %d, miu size: %d, %d\n",
           lamda_ws.rows(),
           lamda_ws.cols(),
           miu_ws.rows(),
           miu_ws.cols());
    if (!flag) {
        printf("dual variable warm start failed!!!\n");
        return 1;
    }

    // 3. distance approach smoothing
    Eigen::MatrixXd x0(4, 1), xf(4, 1);
    x0 << coarse_traj.x.front(), coarse_traj.y.front(),
        coarse_traj.phi.front(), coarse_traj.v.front();
    xf << coarse_traj.x.back(), coarse_traj.y.back(),
        coarse_traj.phi.back(), coarse_traj.v.back();
    Eigen::MatrixXd last_control(2, 1);
    last_control << 0, 0;
    Eigen::MatrixXd state, control, time, lamda, miu;
    planning::DistanceApproachProblem distance_approach(config);
    distance_approach.Solve(x0,
                            xf,
                            last_control,
                            horizon,
                            ts,
                            ego,
                            xws.transpose(),
                            uws.transpose(),
                            lamda_ws,
                            miu_ws,
                            map_bounds,
                            obs_list.size(),
                            obs_edge_num,
                            obsA,
                            obsb, &state, &control, &time, &lamda, &miu);


    plotPython(coarse_traj, state, obs_list);
    return 0;
}
