function plot_mass_sample
% This function is to plot trends of DoRA metric.



% Initial Conditions
R_0      = 0.1; mg_0     = 0.1; mGAP_0   = 0.2;   mGEF_0   = 0.1;
                tg_0     = 0.1;                   tGEF_0   = 0.1;
C0 = [R_0 mGEF_0 mGAP_0 mg_0 tGEF_0 tg_0];
                 
% Parameters
Tot= 1;     tGAP_ss=0.5; 

kon_mGEF =1;     kon_tGEF =1;    kon_mGAP=0.5;
koff_mGEF =1;    koff_tGEF =1;   koff_mGAP =1;
koff_R =1;  koff_mG =1;  koff_tG =1; 
S_all=10.^(-5:0.02:3); 

% % sample 1
kon_R=0.5; kon_mG=10^(-1.4); kon_tG=10^(1);  

K=[1 10];
kfeedback=K(1);
ss1=resp_curve(C0,S_all,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
                       kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,kfeedback,Tot,@fun_mass_and,0); 
                                  
kfeedback=K(2);
ss2=resp_curve(C0,S_all,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
                       kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,kfeedback,Tot,@fun_mass_and,0); 
           

S={ss1,ss2};  mG_ss=[ss1(end,4),ss2(end,4)];
figure(1);plot_dose(S,mG_ss,kon_mG,kon_tG,[189 126 255]/255,'both'); % purple
figure(2);plot_figure(S_all,S);

% % sample 2
kon_R=0.5; kon_mG=10^(1.4); kon_tG=10^(2);  

K=[1 10];
kfeedback=K(1);
ss1=resp_curve(C0,S_all,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
                       kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,kfeedback,Tot,@fun_mass_and,0); 
                                  
kfeedback=K(2);
ss2=resp_curve(C0,S_all,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
                       kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,kfeedback,Tot,@fun_mass_and,0); 
           

S={ss1,ss2};  mG_ss=[ss1(end,4),ss2(end,4)];
figure(1);plot_dose(S,mG_ss,kon_mG,kon_tG,[255 146 106]/255,'mG'); % orange
figure(3);plot_figure(S_all,S);

% % sample 3
kon_R=0.5; kon_mG=10^(0.4); kon_tG=10^(1);  

K=[1 10];
kfeedback=K(1);
ss1=resp_curve(C0,S_all,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
                       kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,kfeedback,Tot,@fun_mass_and,0); 
                                  
kfeedback=K(2);
ss2=resp_curve(C0,S_all,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
                       kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,kfeedback,Tot,@fun_mass_and,0); 
           

S={ss1,ss2};  mG_ss=[ss1(end,4),ss2(end,4)];
figure(1);plot_dose(S,mG_ss,kon_mG,kon_tG,[238 42 123]/255,'mG'); % 'magenta'
figure(4);plot_figure(S_all,S);

% % sample 4
kon_R=0.5; kon_mG=10^(-0.6); kon_tG=10^(0.6);  

K=[1 10];
kfeedback=K(1);
ss1=resp_curve(C0,S_all,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
                       kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,kfeedback,Tot,@fun_mass_and,0); 
                                  
kfeedback=K(2);
ss2=resp_curve(C0,S_all,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
                       kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,kfeedback,Tot,@fun_mass_and,0); 
           

S={ss1,ss2};  mG_ss=[ss1(end,4),ss2(end,4)];
figure(1);plot_dose(S,mG_ss,kon_mG,kon_tG,[0 0 0],'tG');
figure(5);plot_figure(S_all,S);

% % sample 5
kon_R=0.5; kon_mG=10^(1); kon_tG=10^(1);  

K=[1 10];
kfeedback=K(1);
ss1=resp_curve(C0,S_all,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
                       kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,kfeedback,Tot,@fun_mass_and,0); 
                                  
kfeedback=K(2);
ss2=resp_curve(C0,S_all,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
                       kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,kfeedback,Tot,@fun_mass_and,0); 
           

S={ss1,ss2};  mG_ss=[ss1(end,4),ss2(end,4)];
figure(1);plot_dose(S,mG_ss,kon_mG,kon_tG,[255 146 106]/255,'tG'); % orange
figure(6);plot_figure(S_all,S);


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




function plot_dose(S,mG_ss,kon_mG,kon_tG,col,str)
% mG level vs DORA metric
mgr=[];tgr=[];
for i=1:length(S)
    x=S{i}(:,1)./max(S{i}(:,1));y=S{i}(:,4)./max(S{i}(:,4)); z=S{i}(:,6)./max(S{i}(:,6));
    mgr=[mgr,trapz(x,abs(y-x))];
    tgr=[tgr,trapz(x,abs(z-x))];
end
[mgr tgr]



load ('server_mass_and','ss','dist','kmG_all','ktG_all');

[~,i]=min(abs(kmG_all-kon_mG)); [~,j]=min(abs(ktG_all-kon_tG));

if strcmp(str,'both')
    subplot(1,2,1);hold on; set(gcf,'unit','centimeters','position',[2,2,10,5]); 
    plot(ss{i,j}(:,2),dist{i,j}(:,1),'color',col,'linewidth',1);ylim([0 0.5]);
    hold on;plot(mG_ss,mgr,'^');

    subplot(1,2,2);hold on; set(gcf,'unit','centimeters','position',[2,2,10,5]); 
    plot(ss{i,j}(:,2),dist{i,j}(:,2),'color',col,'linewidth',1);
    hold on;plot(mG_ss,tgr,'^');ylim([0 0.5]);
end

if strcmp(str,'mG')
    subplot(1,2,1);hold on; set(gcf,'unit','centimeters','position',[2,2,10,5]); 
    plot(ss{i,j}(:,2),dist{i,j}(:,1),'color',col,'linewidth',1);ylim([0 0.5]);
    hold on;plot(mG_ss,mgr,'^');
end

if strcmp(str,'tG')
    subplot(1,2,2);hold on; set(gcf,'unit','centimeters','position',[2,2,10,5]); 
    plot(ss{i,j}(:,2),dist{i,j}(:,2),'color',col,'linewidth',1);
    hold on;plot(mG_ss,tgr,'^');ylim([0 0.5]);
end

end