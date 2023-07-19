function [path] = bfs(adj, s, t)
% adj Ϊ�ڵ���ͨ�Ծ���s �� t �ֱ�Ϊ�����յ�ı��
adj(adj==0)=inf;
n = size(adj, 1);  % ��ȡ�ڵ����

dist = inf(1, n);  % �������ڵ�ľ���
dist(s) = 0;       % ��㵽�Լ��ľ���Ϊ0

prev = zeros(1, n);  % ��¼���·����ÿ���ڵ��ǰһ���ڵ�
visited = zeros(1, n);  % ��¼ÿ���ڵ��Ƿ��Ѿ�������

queue = s;  % �����г�ʼֻ�����

while ~isempty(queue)
    u = queue(1);  % ȡ�����׽ڵ�
    queue(1) = [];  % �Ӷ������Ƴ��ýڵ�
    visited(u) = 1;  % ��Ǹýڵ��ѱ�����
    
    % ������ýڵ����ڵĽڵ�
    for v = 1:n
        if adj(u, v) == 1 && ~visited(v)  % ���������δ���ʹ�
            dist(v) = dist(u) + 1;  % ���µ��ýڵ�ľ���
            prev(v) = u;  % ��¼�ýڵ��ǰһ���ڵ�
            if v == t  % ����ҵ��յ㣬���ؽ��
                % ������㵽�յ�����·��
                path = t;
                while path(1) ~= s
                    path = [prev(path(1)), path];
                end
                return
            else
                queue(end+1) = v;  % ���ýڵ�������β��
            end
        end
    end
end

% ����޷������յ㣬���ؿ�����
path = [];
end
