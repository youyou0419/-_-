function [v_2] = update_person_sudu(pso_particles,best_person_weizhi)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
x=[];
    x=(pso_particles==best_person_weizhi);
v_2=double(x);
end

