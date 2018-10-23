#!/bin/bash
Green_font="\033[32m" && Yellow_font="\033[33m" && Red_font="\033[31m" && Font_suffix="\033[0m"
Info="${Green_font}[Info]${Font_suffix}"
Error="${Red_font}[Error]${Font_suffix}"
Important="${Red_font}[选择前须知:]${Font_suffix}"
PANEL_DIR=/www/server/panel
PLUGIN_RETURN=在面板安装插件完成之后，从下表选择你要破解的插件:
MAIN_RETURN=${Red_font}[宝塔面板v6.1.2破解脚本]${Font_suffix}

git_check(){
	GIT_V=`git --version | grep -q version`
if [ $? = 0 ]; then
    echo -e "${Info} Git已安装，开始下一步操作!"
else
	echo -e "${Error} 未安装Git，开始安装Git!"
	check_system
	install_git
fi
}

check_system() {
    if grep -Eqii "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
        DISTRO='CentOS'
        PM='yum'
    elif grep -Eqi "Red Hat Enterprise Linux Server" /etc/issue || grep -Eq "Red Hat Enterprise Linux Server" /etc/*-release; then
        DISTRO='RHEL'
        PM='yum'
    elif grep -Eqi "Aliyun" /etc/issue || grep -Eq "Aliyun" /etc/*-release; then
        DISTRO='Aliyun'
        PM='yum'
    elif grep -Eqi "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
        DISTRO='Debian'
        PM='apt'
    elif grep -Eqi "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
        DISTRO='Ubuntu'
        PM='sudo'
    else
        DISTRO='unknow'
    fi
}

install_git(){
	case ${PM} in
		yum)
			yum -y install sudo
			yum -y update 
			sudo yum -y install git
		;;
		apt)
			apt -y install sudo
			sudo apt -y update
			sudo apt-get -y install git
		;;
		sudo)
			sudo apt -y update
			sudo apt-get -y install git
		;;
		*)
			echo -e "${Error} 不支持您的系统 !"
		;;
	esac
	echo -e "${Info} Git安装完成 !"
}

install_bt_panel_pro(){
	curl http://download.bt.cn/install/update6.sh|bash
	echo -e "${Info} 宝塔专业版安装完成，正在进行下一步操作!"
}

get_crack_file(){
	git clone https://github.com/madlifer/btpanelv6.1_crack.git
}

copy_class_file(){
	cp -pf /root/btpanelv6.1_crack/panelPlugin.py ${PANEL_DIR}/class/panelPlugin.py
	echo -e "${Info} 复制Class文件完成，正在进行下一步操作!"
}

restart_btpanel(){
	/etc/init.d/bt restart
	echo -e "${Info} 重启宝塔面板完成，正在进行下一步操作!"
}

install_tamper_proof(){
	cp -pf /root/btpanelv6.1_crack/tamper_proof_main.py ${PANEL_DIR}/plugin/tamper_proof/tamper_proof_main.py
	PLUGIN_RETURN=${Red_font}[网站防篡改程序]${Font_suffix}破解完成，继续破解或返回主菜单: && plugin_choose
}

install_btwaf_httpd(){
	cp -pf /root/btpanelv6.1_crack/btwaf_httpd_main.py ${PANEL_DIR}/plugin/btwaf_httpd/btwaf_httpd_main.py
	PLUGIN_RETURN=${Red_font}[Apache防火墙]${Font_suffix}破解完成，继续破解或返回主菜单: && plugin_choose
}

install_total_main(){
	cp -pf /root/btpanelv6.1_crack/total_main.py ${PANEL_DIR}/plugin/total/total_main.py
	PLUGIN_RETURN=${Red_font}[网站监控报表]${Font_suffix}破解完成，继续破解或返回主菜单: && plugin_choose
}

install_btwaf(){
	cp -pf /root/btpanelv6.1_crack/btwaf_main.py ${PANEL_DIR}/plugin/btwaf/btwaf_main.py
	PLUGIN_RETURN=${Red_font}[Nginx防火墙]${Font_suffix}破解完成，继续破解或返回主菜单: && plugin_choose
}

install_load_leveling(){
	cp -pf /root/btpanelv6.1_crack/load_leveling_main.py ${PANEL_DIR}/plugin/load_leveling/load_leveling_main.py
	PLUGIN_RETURN=${Red_font}[宝塔负载均衡]${Font_suffix}破解完成，继续破解或返回主菜单: && plugin_choose
}

install_masterslave(){
	cp -pf /root/btpanelv6.1_crack/masterslave_main.py ${PANEL_DIR}/plugin/masterslave/masterslave_main.py
	PLUGIN_RETURN=${Red_font}[MYSQL主从复制]${Font_suffix}破解完成，继续破解或返回主菜单: && plugin_choose
}

install_task_manager(){
	cp -pf /root/btpanelv6.1_crack/task_manager_main.py ${PANEL_DIR}/plugin/task_manager/task_manager_main.py
	PLUGIN_RETURN=${Red_font}[任务管理器]${Font_suffix}破解完成，继续破解或返回主菜单: && plugin_choose
}

install_rsync(){
	cp -pf /root/btpanelv6.1_crack/rsync_main.py ${PANEL_DIR}/plugin/rsync/rsync_main.py
	PLUGIN_RETURN=${Red_font}[数据同步工具]${Font_suffix}破解完成，继续破解或返回主菜单: && plugin_choose
}

del_crack_file(){
	rm -rf /root/btpanelv6.1_crack
	MAIN_RETURN=${Red_font}[删除破解包]${Font_suffix}操作已完成。
}

setup(){
	git_check
	install_bt_panel_pro
	get_crack_file
	copy_class_file
	restart_btpanel
	MAIN_RETURN=${Red_font}[安装前准备]${Font_suffix}操作已完成。
	main
}

plugin_choose(){
clear
echo -e "${Green_font}
#====================================================
# ${Important} 必须先在面板成功安装插件才能进行破解。
#====================================================
# ${PLUGIN_RETURN}${Green_font}
#====================================================
#          1.网页防篡改程序
#          2.Apache防火墙
#          3.网站监控报表
#          4.Nginx防火墙
#          5.宝塔负载均衡
#          6.MYSQL主从复制
#          7.任务管理器
#          8.数据同步工具
#          9.返回主菜单
#====================================================
${Font_suffix}
${Font_suffix}"

read -p "输入数字以选择:" choose_function

while [[ ! "${choose_function}" =~ ^[1-9]$ ]]
	do
		echo -e "${Error} 无效输入"
		echo -e "${Info} 请重新选择" && read -p "输入数字以选择:" choose_function
	done

if [[ "${choose_function}" == "1" ]]; then
	install_tamper_proof
elif [[ "${choose_function}" == "2" ]]; then
	install_btwaf_httpd
elif [[ "${choose_function}" == "3" ]]; then
	install_total_main
elif [[ "${choose_function}" == "4" ]]; then
	install_btwaf
elif [[ "${choose_function}" == "5" ]]; then
	install_load_leveling
elif [[ "${choose_function}" == "6" ]]; then
	install_masterslave
elif [[ "${choose_function}" == "7" ]]; then
	install_task_manager
elif [[ "${choose_function}" == "8" ]]; then
	install_rsync
elif [[ "${choose_function}" == "9" ]]; then
	main
fi
}

main(){
clear
echo -e "${Green_font}
#=======================================
# Name:         bt-6.1-crack
# Project:      https://git.io/fxiwt
# requirement:  bt v6.1 free version
# Version:      0.0.1
# Author:       madlifer
# Thanks:       @king51
# Copyright:    https://madevo.net
#=======================================
${Font_suffix}"

echo -e "${MAIN_RETURN}"
echo -e "1.安装前准备\n2.进行安装\n3.删除破解包\n4.退出脚本"
read -p "输入数字以选择:" function

while [[ ! "${function}" =~ ^[1-4]$ ]]
	do
		echo -e "${Error} 无效输入"
		echo -e "${Info} 请重新选择" && read -p "输入数字以选择:" function
	done

if [[ "${function}" == "1" ]]; then
	setup
elif [[ "${function}" == "2" ]]; then
	plugin_choose
elif [[ "${function}" == "2" ]]; then
	del_crack_file
else
	clear
	exit 1
fi
}

