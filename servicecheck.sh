clear
i="y"
while [ $i = "y" ]
do
echo -e "1.mysql\n2.rabbitmq-server\n3.apache2\n4.glance-registry\n5.glance-api\n\
6.nova-api\n7.nova-cert\n8.nova-consoleauth\n9.nova-conductor\n10.nova-scheduler\n\
11.nova-novncproxy\n12.nova-compute\n13.neutron-server\n14.openvswitch-switch\n15.neutron-plugin-openvswitch-agent\n\
16.neutron-l3-agent\n17.neutron-dhcp-agent\n18.neutron-metadata-agent\n19.cinder-scheduler\n20.cinder-api\n\
21.tgt\n22.cinder-volume\n23.heat-api\n24.heat-engine\n25.heat-api-cfn\n\
26.ceilometer-api\n27.ceilometer-collector\n28.ceilometer-agent-central\n29.ceilometer-agent-notification\n30.ceilometer-alarm-evaluator\n\
31.ceilometer-agent-compute\n32.ceilometer-alarm-notifier\n33.mongodb\n34.libvirt-bin\n35.qemu-kvm\n36.memcached"
echo "Select the service you need to start/stop/restart or to know its status"
read option
echo "Enter the action you need to perform on the selected service [start|stop|status|restart|force-reload|systemd-start]"
read -r action
action=$action
case $option in
	1)service mysql $action;;
	2)service rabbitmq-server $action;;
	3)service apache2 $action;;
	4)service glance-registry $action;;
	5)service glance-api $action;;
	6)service nova-api $action;;
	7)service nova-cert $action;;
	8)service nova-consoleauth $action;;
	9)service nova-conductor $action;;
	10)service nova-scheduler $action;;
	11)service nova-novncproxy $action;;
	12)service nova-compute $action;;
	13)service neutron-server $action;;
	14)service openvswitch-switch $action;;
	15)service neutron-plugin-openvswitch-agent $action;;
	16)service neutron-l3-agent $action;;
	17)service neutron-dhcp-agent $action;;
	18)service neutron-metadata-agent $action;;
	19)service cinder-scheduler $action;;
	20)service cinder-api $action;;
	21)service tgt $action;;
	22)service cinder-volume $action;;
	23)service heat-api $action;;
	24)service heat-engine $action;;
	25)service heat-api-cfn $action;;
	26)service ceilometer-api $action;;
	27)service ceilometer-collector $action;;
	28)service ceilometer-agent-central $action;;
	29)service ceilometer-agent-notification $action;;
	30)service ceilometer-alarm-evaluator $action;;
	31)service ceilometer-agent-compute $action;;
	32)service ceilometer-alarm-notifier $action;;
	33)service mongodb $action;;
	34)service libvirt-bin $action;;
	35)service qemu-kvm $action;;
	36)service memcached $action;;
	*)echo "Invalid Choice";;
esac
echo "Do u want to continue ?[y/n]"
read i
if [ $i != "y" ]
then
    exit
fi
done
