function [pso_particles] = update_particle(pso_particles,pso_velocity,population_size,network_request,index,UAV_node)
%UPDATE_PARTICLE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    start_node=network_request{1,2}(index,1) ;
    end_node=network_request{1,2}(index,2);
for i=1:population_size
    
    for j=2:(network_request{1,3}(index,1)-1)
        if pso_velocity(i,j)==0
           a=randi([1, UAV_node]);
           while a==end_node||a==start_node
                 a=randi([1, UAV_node]);
           end
           pso_particles(i,j)=a;
        end
    end
        while length(pso_particles(i,:))~=length(unique(pso_particles(i,:)))%����������ɵ�ӳ�䷽���г������ظ���λ�ã���ô���ٴ��������ɣ�֪������vnfӳ�������ڵ㶼��һ���ſ���
                for j=2:(network_request{1,3}(index,1)-1)
        if pso_velocity(i,j)==0
           a=randi([1, UAV_node]);
           while a==end_node||a==start_node
                 a=randi([1, UAV_node]);
           end
           pso_particles(i,j)=a;
        end
    end
            end
    
    
end
end
            





