function [alpha, mu, sigma] = EMM(Y, M, T)

%EMM EM+GMM ͬʱGMMΪ�������ϸ�˹ģ��
%Ϊ�˼򻯳��򣬳������ǲ�ʹ��kmeans�������г�ʼ��
%����˵����
% Y:���� N*D
% M:ģʽ�������ڷ��������У�����������
% T:��������

%  ��ʼ������
[N, D] = size(Y);
alpha = ones(M, 1).*1/M;
mu = rand(M, D);
sigma = zeros(D, D, M);
for m = 1:M
    sigma(:, :, m) = eye(D);
end

% EM�׶�
 for t = 1:T
    p_m_all = zeros(N,1); % k�۲��������ڸ�ģ�͵��ܸ���
    mu_up = zeros(M,D); % ��ֵ���¹�ʽ�ϲ���
    sigma_up = zeros(D,D,M); % Э������¹�ʽ�ϲ���
    comm = zeros(M,D); % ��Ҫ�ظ�����Ĳ��ֵ��������
    alpha_up = zeros(M,1); % alpha���¹�ʽ���ϲ���
    for n = 1:N
        for m = 1:M
            p_m_all(n, 1) = p_m_all(n,1)+alpha(m,1)*mvnpdf(Y(n,:),mu(m,:),sigma(:,:,m));
        end
    end
    
    % ���� alpha mu sigma 
    for m = 1:M
        for n = 1:N
            comm(m, n) = (alpha(m,1)*mvnpdf(Y(n,:),mu(m,:),sigma(:,:,m)))./p_m_all(n,1);
            alpha_up(m,1)=alpha_up(m,1)+comm(m,n);
            mu_up(m,:)=mu_up(m,:)+Y(n,:).*comm(m,n);
        end
        
        mu(m,:)=mu_up(m,:)./alpha_up(m,1);
        
        for n=1:N
             sigma_up(:,:,m)=sigma_up(:,:,m)+(Y(n,:)-mu(m,:)).'*(Y(n,:)-mu(m,:))*comm(m,n);
        end
        
        sigma(:,:,m)=sigma_up(:,:,m)./alpha_up(m,1);
        
        alpha(m,1)=alpha_up(m,1)/N;
        
    end
 end

end 


