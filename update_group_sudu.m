function  [v_3] = update_group_sudu(pso_particles,best_gruop_weizhi,population_size)
%SUDU_GROUP_UPDATE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
x=[];
for i=1:population_size
    x(i,:)=double((pso_particles(i,:)==best_gruop_weizhi));
end
v_3=double(x);
end