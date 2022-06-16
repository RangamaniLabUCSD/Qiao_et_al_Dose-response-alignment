%This function is the same as server_mass except the Hill-function kinetics
%and the negative feedback is modeled by AND logic


% Initial condition
R_0      = 0.1; mg_0     = 0.1; mGAP_0   = 0.2;   mGEF_0   = 0.1;
                tg_0     = 0.1;                   tGEF_0   = 0.1;
C0 = [R_0 mGEF_0 mGAP_0 mg_0 tGEF_0 tg_0];
                 
% Parameters
Tot= 1;     tGAP_ss=0.5; 

kon_mGEF =1;     kon_tGEF =1;    kon_mGAP=0.5;
koff_mGEF =1;    koff_tGEF =1;   koff_mGAP =1;
koff_R =1;  koff_mG =1;  koff_tG =1; 
S_all=10.^(-5:0.02:3); 

% Simulation
nega_all=[0 10.^(-1:0.2:2.6)]; 
kR_all=10.^(-2:0.2:2);  kmG_all=10.^(-2:0.2:2);


    
f=@fun_Hill_and;

% The element of dist is DoRA metric, and that of ss is steady state of receptor and GTPase
dist=cell(length(kR_all),length(kmG_all));  ss=dist;
name={'server_and_tG_0dot01.mat','server_and_tG_1.mat','server_and_tG_10.mat'}; s=0;

parpool(12);
for kon_tG=[0.01 1 10]
    s=s+1;

    for i=1:length(kR_all)
        tic
        Temp_d=cell(1,length(kmG_all));  Temp_s=cell(1,length(kmG_all));
        parfor j=1:length(kmG_all)
            kon_R=kR_all(i);  kon_mG=kmG_all(j);  
            temp_d=zeros(length(nega_all),2); temp_s=zeros(length(nega_all),3);
    
            for k=1:length(nega_all)
                % calculte DoRA metric for each parameter set
                kfeedback=nega_all(k);        
                Y=resp_curve(C0,S_all,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
                                      kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,kfeedback,Tot,f,1.5); 
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


    save (name{s},'dist','dist','nega_all','kR_all','kmG_all','ss');

end



