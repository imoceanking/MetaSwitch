 PS7350是基于 Intel Tofino系列的白盒交换机，支持P4可编程。主要应用于数据中心TOR(Top of Rack)交换机，
 以及Spine-Leaf 架构中的 Spine或Leaf交换机。 通过P4可编程特性，可支持数据中心不同的网关应用场景。 


1. semptian目录下主要包括PS7350设备硬件相关的配置以及操作平台驱动的功能接口。
将文件中semptian目录放在sonic-buildimage/device/目录下


2. sonic-platform-modules-semptian目录下主要包括具体设备平台驱动内核模块及应用工具。
将platform-modules-semptian.mk deb编译文件和sonic-platform-modules-semptian目录放在sonic-buildimage/platform/barefoot/目录下

注意：
  platform/barefoot/rule,mk中需要增加
  include $(PLATFORM_PATH)/platform-modules-semptian.mk去编译PS7350平台驱动

3. 为了能兼容ps7350端口映射文件，需要修改sde中默认的端口映射文件
将端口映射文件board_lane_map.json 替换 bf-sde-{version}/pkgsrc/bf-platforms/platforms/tofino-bringup/board_lane_map.json

4. SDE编译参考<<635306-0001_Building_SONiC_with_SDE_9.4.pdf>>

注意:
1. 修改build_sonic_platform_multiprofile.sh文件，在build platform debain脚本中创建x86_64-semptian_ps7350_32x-r0软连接
  ln -s x86_64-accton_wedge100bf_65x-r0 x86_64-semptian_ps7350_32x-r0
