function server_mass_mGAP
% This function is to sample in the parameter space, and then calculate the
% DoRA metric for each parameter set.



% Initial Conditions
R_0      = 0.1; mg_0     = 0.1; mGAP_0   = 0.2;   mGEF_0   = 0.1;
                tg_0     = 0.1;                   tGEF_0   = 0.1;
C0 = [R_0 mGEF_0 mGAP_0 mg_0 tGEF_0 tg_0];
                 
% Kinetic parameters
Tot= 1;     tGAP_ss=0.5; 

kon_mGEF =1;     kon_tGEF =1;
koff_mGEF =1;    koff_tGEF =1;   koff_mGAP =1;
koff_R =1;  koff_mG =1;  koff_tG =1; 
S_all=10.^(-5:0.02:3); 

% simulation
mGAP_all=[0.01:0.02:0.1,0.15:0.05:0.4,0.5:0.1:1];  
kmG_all=10.^(-2:0.1:2);  ktG_all=10.^(-2:0.1:2);

% The element of dist is DoRA metric, and that of ss is steady state of receptor and GTPase
dist=cell(length(kmG_all),length(ktG_all));  ss=dist;  


parpool(12);
for i=1:length(kmG_all)
    tic
    Temp_d=cell(1,length(ktG_all));  Temp_s=cell(1,length(ktG_all));
    parfor j=1:length(ktG_all)
        kon_R=0.5;  kon_mG=kmG_all(i); kon_tG=ktG_all(j);  
        temp_d=zeros(length(mGAP_all),2); temp_s=zeros(length(mGAP_all),3);

        for k=1:length(mGAP_all)
            % calculte DoRA metric for each parameter set
            kon_mGAP=mGAP_all(k);    
            Y=resp_curve(C0,S_all,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
                                        kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,Tot,@fun_mass_action,0,'kon_mGAP',kon_mGAP); 
            r_range =Y(:,1);
            mg_range=Y(:,4); 
            tg_range=Y(:,6); 

            x=r_range/max(r_range);  y=mg_range/max(mg_range); z=tg_range/max(tg_range);
            
            temp_d(k,:)=[trapz(x,abs(y-x)),trapz(x,abs(z-x))];
            
            temp_s(k,:)=Y(end,[1 4 6]);
        end
        Temp_d{j}=temp_d;
        Temp_s{j}=temp_s;
    end
    dist(i,:)=Temp_d;
    ss(i,:)=Temp_s;
    toc
    i
end

save ('server_mass_mGAP.mat','dist','mGAP_all','kmG_all','ktG_all','ss');



