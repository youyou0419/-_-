function connected = check_connection(node1, node2)
global UAV_lianjie_matrix;
% A: ��ͨ�Ծ���
% node1, node2: �ڵ���
% connected: ����ֵ������ڵ�������Ϊ1������Ϊ0

if UAV_lianjie_matrix(node1, node2) == 1 || UAV_lianjie_matrix(node2, node1) == 1
    connected = 1;
else
    connected = 0;
end
