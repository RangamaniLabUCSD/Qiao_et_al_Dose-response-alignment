set(0,'DefaultLineLineWidth',1);
set(0,'DefaultAxesFontSize',12,'DefaultAxesFontWeight','bold');
set(0,'DefaultTextFontSize',12,'DefaultTextFontWeight','bold');

% Initial Conditions and kinetic parameters
R_0      = 0.1; mg_0     = 0.1;  mGAP_0   = 0.2;   mGEF_0   = 0.1;
tg_0     = 0.1;                   tGEF_0   = 0.1;
C0 = [R_0 mGEF_0 mGAP_0 mg_0 tGEF_0 tg_0];
                 
Tot= 1;     tGAP_ss=0.5; 
kon_mGEF =1;     kon_tGEF =1;    kon_mGAP=0.5;
koff_mGEF =1;    koff_tGEF =1;   koff_mGAP =1;
koff_R =1;  koff_mG =1;  koff_tG =1; 

% % Figure S5
kon_R=1; kon_mG=10^(1); kon_tG=10^(1);    flag=3;  fun=@fun_mass_and;

% % Figure S6
kon_R=0.1; kon_mG=10^(-0.5); kon_tG=10^(-0.5); flag=3;  fun=@fun_mass_and;


% % Figure S7
%kon_R=1; kon_mG=10^(1); kon_tG=10^(1);    flag=4;  fun=@fun_mass_or;


% % Figure S8
kon_R=0.1; kon_mG=10^(-0.5); kon_tG=10^(-0.5); flag=4;  fun=@fun_mass_or;



% other parameters
S_all=10.^(-4:0.1:3);    str_nega=[1 5 10];
mg_range=zeros(length(S_all),length(str_nega));  r_range=mg_range; 
ana_darea=zeros(2,length(str_nega));
r=1;  
figure(1);set(gcf,'unit','centimeters','position',[2,2,20,15]);
figure(2);set(gcf,'unit','centimeters','position',[2,2,20,15]);
le={}; 

for i=1:length(str_nega)
    % simulate the system
    kfeedback=str_nega(i);    
    ss=resp_curve(C0,S_all,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
                       kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,kfeedback,Tot,fun,0); 
                   
    mg_range(:,i)=ss(:,4);  r_range(:,i)=ss(:,r);

    % Function H(y), which we can obatain its monotonicity  
    e=kfeedback/(Tot*kon_mG); f=kfeedback/kon_mG; % because kon=1 and koff=1
    b=tGAP_ss/kon_tG; c=kon_mGAP/koff_mGAP/(Tot*kon_mG);
    d=kfeedback/kon_mG;
    if flag==3
        H=@(y)(d*y.^2./(y+b));    dH=@(y)(d*(y.^2+2*b*y)./(y+b).^2);
    end
    if flag==4
        H=@(y)(e*y+f*y./(y+b));   dH=@(y)(e+f*b./(y+b).^2);
    end
    F=@(y)(dH(y).*y./H(y)+(c+H(y)).*Tot./((Tot-y).*H(y)));
    F1=@(y)(dH(y).*y./H(y));
    F2=@(y)((c+H(y)).*Tot./((Tot-y).*H(y)));
    
    
    figure(1);subplot(3,3,1);hold on;
    plot(mg_range(:,i),F1(mg_range(:,i))); 
    p=title('$H1 \Big(i.e.,  \frac{\partial ln h(y)}{\partial ln y}\Big)$');set(p,'Interpreter','latex') 
    xlabel('y(i.e., mG)');

   
    figure(1);subplot(3,3,2);hold on;
    plot(mg_range(:,i),log10(F2(mg_range(:,i)))); 
    p=title('$log(H2), i.e.,log\Big(\frac{c+h(y)}{h(y)}\frac{[mG]_{tot}}{[mG]_{tot}-y}\Big)$');set(p,'Interpreter','latex') 
    xlabel('y(i.e., mG)');

    figure(1);subplot(3,3,3);hold on;
    Hy=F(mg_range(:,i));
    plot(mg_range(:,i),log10(Hy)); 
    p=title('$log(H(y))\Big(i.e., log(H1+H2)\Big)$'); set(p,'Interpreter','latex') 
    xlabel('y(i.e., mG)');
    

    for kk=1:2 
        eval(['figure(',num2str(kk),');']);
        subplot(3,3,4);hold on;
        if kk==1
            minus_over_konH=-1./(Hy.*str_nega(i));
            p=title('$-\frac{1}{k_{feedback}^{on}H(y)}$'); set(p,'Interpreter','latex') 
        else
            minus_over_konH= -1./(Hy.*str_nega(i)).*(b./(mg_range(:,i)+b));
            p=title('$-\frac{1}{k_{feedback}^{on}H(y)}\frac{b}{y+b}$'); set(p,'Interpreter','latex') 
        end
        plot(r_range(:,i),minus_over_konH); 
        xlabel('x(i.e., R)');

        
        subplot(3,3,5);hold on;
        plot(r_range(:,i),minus_over_konH-minus_over_konH(end));  plot([0,r_range(end,i)],zeros(1,2),'k')
        if kk==1
           p=title('$-\frac{1}{k_{feedback}H(y)}+\frac{1}{k_{feedback}H(y)}|_{y=y_{max}}$'); set(p,'Interpreter','latex') 
        else
           p=title('$-\frac{1}{k_{feedback}^{on}H(y)}\frac{b}{y+b}+\frac{1}{k_{feedback}H(y)}\frac{b}{y+b}|_{y=y_{max}}$'); set(p,'Interpreter','latex') 
        end
        xlabel('x(i.e., R)');
        

        subplot(3,3,6);hold on;
        if kk==1
            integral_part=(minus_over_konH-minus_over_konH(end)).*mg_range(:,i)/mg_range(end,i);
            p=title('$\Big(-\frac{1}{k_{feedback}H(y)}+\frac{1}{k_{feedback}H(y)}|_{y=y_{max}}\Big)*y/y_{max}$');set(p,'Interpreter','latex') 
        else
            integral_part=(minus_over_konH-minus_over_konH(end)).*(mg_range(:,i)./(mg_range(:,i)+b))./(mg_range(end,i)./(mg_range(end,i)+b));
            p=title('$\Big(-\frac{1}{k_{feedback}H(y)}+\frac{1}{k_{feedback}H(y)}|_{y=y_{max}}\Big)*\frac{y/(y+b)}{y_{max}/(y_{max}+b)}$');set(p,'Interpreter','latex') 
        end
        plot(r_range(:,i),integral_part);   plot([0,r_range(end,i)],zeros(1,2),'k')
        xlabel('x(i.e., R)');

        ana_darea(kk,i)=trapz(ss(:,r)./max(ss(:,r)),integral_part);
        le=[le,['k_{feedback}=',num2str(str_nega(i))]];   
    end       
end



str_nega_refined=linspace(0.1,max(str_nega),20); 
area=zeros(2,length(str_nega_refined)); 
num_darea=zeros(2,length(str_nega_refined)); 
for i=1:length(str_nega_refined)
    % dora metric  
    kfeedback=str_nega_refined(i);    
    ss=resp_curve(C0,S_all,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
                       kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,kfeedback,Tot,fun,0); 
                   
                   
    y=ss(:,4)./max(ss(:,4));  x=ss(:,r)./max(ss(:,r));    z=ss(:,6)./max(ss(:,6)); 
    area(:,i)=[trapz(x,abs(y-x)),trapz(x,abs(z-x))];
    
    % d metric/d k_{feedback}
    kfeedback=str_nega_refined(i)+0.05;    
    temp1=resp_curve(C0,S_all,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
                       kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,kfeedback,Tot,fun,0);      
    kfeedback=str_nega_refined(i)-0.05;
    temp2=resp_curve(C0,S_all,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
                       kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,kfeedback,Tot,fun,0); 
                   

    x=temp1(:,r)./max(temp1(:,r));y=temp1(:,4)./max(temp1(:,4)); z=temp1(:,6)./max(temp1(:,6)); 
    s1=[trapz(x,abs(y-x)),trapz(x,abs(z-x))];
    x=temp2(:,r)./max(temp2(:,r));y=temp2(:,4)./max(temp2(:,4)); z=temp2(:,6)./max(temp2(:,6)); 
    s2=[trapz(x,abs(y-x)),trapz(x,abs(z-x))];

    num_darea(:,i)=(s1-s2)/0.1;   
end    
 
%plot deriative of dora metric for tG
figure(1);subplot(3,3,7);hold on;
plot(str_nega,ana_darea(1,:),'ko'); plot(str_nega_refined,num_darea(1,:),'k'); 
plot([0,str_nega(end)],zeros(1,2),'k')
p=legend('$\int\Big(-\frac{1}{k_{mGAP}^{on}H(y)}+\frac{1}{k_{mGAP}^{on}H(y)}|_{y=y_{max}}\Big)yy_{max}$',...
        '$\frac{\partial AUC}{\partial k_{mGAP}^{on}}$');  set(p,'Interpreter','latex') 
xlabel('k_{feedback}');

%plot dora metric for mG
figure(1);subplot(3,3,8);hold on; % plot DoRA metric
plot(str_nega_refined,area(1,:),'k-');%ylim([0.7 0.8])
xlabel('k_{feedback}');

%plot deriative of dora metric for tG
figure(2);subplot(3,3,7);hold on;
plot(str_nega,ana_darea(2,:),'ko'); plot(str_nega_refined,num_darea(2,:),'k'); 
plot([0,str_nega(end)],zeros(1,2),'k')
p=legend('$\int\Big(-\frac{1}{k_{mGAP}^{on}H(y)}+\frac{1}{k_{mGAP}^{on}H(y)}|_{y=y_{max}}\Big)yy_{max}$',...
        '$\frac{\partial AUC}{\partial k_{mGAP}^{on}}$');  set(p,'Interpreter','latex') 
xlabel('k_{feedback}');

 
%plot dora metric for tG
figure(2);subplot(3,3,8);hold on; % plot DoRA metric
plot(str_nega_refined,area(2,:),'k-');%ylim([0.7 0.8])
xlabel('k_{feedback}');


