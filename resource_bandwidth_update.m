function [real_time_bandwidth_resources] = resource_bandwidth_update(real_time_bandwidth_resources,request_bandwidth_source,best_map_path)
%����ʵʱ������Դ�ĸ���
for i=1:(length(best_map_path)-1)
    real_time_bandwidth_resources(best_map_path(1,i),best_map_path(1,i+1))=real_time_bandwidth_resources(best_map_path(1,i),best_map_path(1,i+1))- request_bandwidth_source;
     real_time_bandwidth_resources(best_map_path(1,i+1),best_map_path(1,i))=real_time_bandwidth_resources(best_map_path(1,i+1),best_map_path(1,i))- request_bandwidth_source;
    

end

