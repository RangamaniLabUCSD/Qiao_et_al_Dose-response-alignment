function plot_Hill_sample
% This function is the same as plot_mass_sample except the Hill-function kinetics

% Initial Conditions
R_0      = 0.1; mg_0     = 0.1; mGAP_0   = 0.2;   mGEF_0   = 0.1;
                tg_0     = 0.1;                   tGEF_0   = 0.1;
C0 = [R_0 mGEF_0 mGAP_0 mg_0 tGEF_0 tg_0];
                 
% Parameters
Tot= 1;     tGAP_ss=0.5; 

kon_mGEF =1;     kon_tGEF =1; kon_mGAP=0.5;
koff_mGEF =1;    koff_tGEF =1;   koff_mGAP =1;
koff_R =1;  koff_mG =1;  koff_tG =1; 
S_all=10.^(-3:0.02:3); 

% simulation


% % sample 1
kon_R=10^0.2; kon_mG=10^(0.2); kon_tG=1;  

K=[0.1 1];
ss1=resp_curve(C0,S_all,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
                      kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,Tot,@fun_Hill,1.5,'kon_mGAP',K(1)); 
           

ss2=resp_curve(C0,S_all,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
                      kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,Tot,@fun_Hill,1.5,'kon_mGAP',K(2)); 


S={ss1,ss2};  mG_ss=[ss1(end,4),ss2(end,4)];
figure(1);plot_dose(S,mG_ss,kon_R,kon_mG,1);
figure(2);plot_figure(S_all,S);


% % sample 2
kon_R=10^(-0.8); kon_mG=10^(0); kon_tG=1;  

K=[0.1 1];
ss1=resp_curve(C0,S_all,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
                      kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,Tot,@fun_Hill,1.5,'kon_mGAP',K(1)); 
           

ss2=resp_curve(C0,S_all,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
                      kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,Tot,@fun_Hill,1.5,'kon_mGAP',K(2)); 
           

S={ss1,ss2};  mG_ss=[ss1(end,4),ss2(end,4)];
figure(1);plot_dose(S,mG_ss,kon_R,kon_mG,2);
figure(3);plot_figure(S_all,S);


% % sample 3
kon_R=10^(-1.2); kon_mG=10^(-1.2); kon_tG=1;  

K=[0.01 1];
ss1=resp_curve(C0,S_all,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
                      kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,Tot,@fun_Hill,1.5,'kon_mGAP',K(1)); 
           

ss2=resp_curve(C0,S_all,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
                      kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,Tot,@fun_Hill,1.5,'kon_mGAP',K(2)); 
           

S={ss1,ss2};  mG_ss=[ss1(end,4),ss2(end,4)];
figure(1);plot_dose(S,mG_ss,kon_R,kon_mG,3);
figure(4);plot_figure(S_all,S);


% more smooth curve
K=[0.01:0.005:0.02,0.02:0.05:0.1,0.2:0.4:1]; mgr=zeros(size(K)); tgr=zeros(size(K)); ss_mg=mgr;
for i=1:length(K)
     ss=resp_curve(C0,S_all,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
                      kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,Tot,@fun_Hill,1.5,'kon_mGAP',K(i)); 
     x=ss(:,1)./max(ss(:,1));y=ss(:,4)./max(ss(:,4)); z=ss(:,6)./max(ss(:,6));
     mgr(i)=trapz(x,abs(y-x));
     tgr(i)=trapz(x,abs(z-x));
     ss_mg(i)=ss(end,4);
end

figure(1);
subplot(1,2,1);hold on;plot(ss_mg,mgr,'-','color','b','linewidth',0.25)
subplot(1,2,2);hold on;plot(ss_mg,tgr,'-','color',[0 176 80]./255,'linewidth',0.25)

end





function plot_figure(S_all,S)
% plot the dose-response curves 
for i=1:length(S)
    eval(['ss',num2str(i),'=S{i};']);
end

set(0,'DefaultLineLineWidth',1);
set(0,'DefaultAxesFontSize',20,'DefaultAxesFontWeight','bold');
set(0,'DefaultTextFontSize',20,'DefaultTextFontWeight','bold');


H=linspace(0.3,1,length(S));
subplot(2,1,1);hold on; set(gcf,'unit','centimeters','position',[2,2,20,20]);
for i=1:length(S)
    h=plot(S_all,S{i}(:,4), 'Color','b','LineStyle','-','Linewidth',1); h.Color(4)=H(i);
    h=plot(S_all,S{i}(:,6), 'Color',[0 176 80]./255,'LineStyle','-','Linewidth',1); h.Color(4)=H(i);
end
ylabel('mG*'); set(gca,'xscale','log'); set(gca,'xtick',10.^([-2 0 2]))
xlim([min(S_all), max(S_all)])

subplot(2,1,2);hold on; 
h1=plot(S_all,ss1(:,1)./max(ss1(:,1)),'Color','r','LineStyle','-','Linewidth',1); 
for i=1:length(S)
    h=plot(S_all,S{i}(:,4)./max(S{i}(:,4)), 'Color','b','LineStyle','-','Linewidth',1); h.Color(4)=H(i);
    h=plot(S_all,S{i}(:,6)./max(S{i}(:,6)), 'Color',[0 176 80]./255,'LineStyle','-','Linewidth',1); h.Color(4)=H(i);
end
xlabel('Stimulus');set(gca,'xscale','log');set(gca,'xtick',10.^([-2 0 2]))
xlim([min(S_all), max(S_all)])

end




function plot_dose(S,mG_ss,kon_R,kon_mG,line_width)
% plot mG level vs DoRA metric
mgr=[];tgr=[];
for i=1:length(S)
    x=S{i}(:,1)./max(S{i}(:,1));y=S{i}(:,4)./max(S{i}(:,4)); z=S{i}(:,6)./max(S{i}(:,6));
    mgr=[mgr,trapz(x,abs(y-x))];
    tgr=[tgr,trapz(x,abs(z-x))];
end
[mgr tgr]


load ('server_Hill_tG_1_mGAP','ss','dist','kR_all','kmG_all');

[~,i]=min(abs(kR_all-kon_R)); [~,j]=min(abs(kmG_all-kon_mG));

subplot(1,2,1);hold on; set(gcf,'unit','centimeters','position',[2,2,10,5]); 
plot(ss{i,j}(:,2),dist{i,j}(:,1),'b','linewidth',line_width);ylim([0 0.5]);
hold on;plot(mG_ss,mgr,'^');

subplot(1,2,2);hold on; set(gcf,'unit','centimeters','position',[2,2,10,5]); 
plot(ss{i,j}(:,2),dist{i,j}(:,2),'color',[0 176 80]./255,'linewidth',line_width);
hold on;plot(mG_ss,tgr,'^');ylim([0 0.5]);

end