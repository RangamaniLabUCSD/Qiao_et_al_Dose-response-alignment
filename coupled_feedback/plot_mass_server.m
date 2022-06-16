set(0,'DefaultLineLineWidth',1);
set(0,'DefaultAxesFontSize',20,'DefaultAxesFontWeight','bold');
set(0,'DefaultTextFontSize',20,'DefaultTextFontWeight','bold');

%% plot DoRA trend vs mG level (the middle panel in Figure 3B)
load server_mass_and

ss_initial=[];  trend_mg=[];  trend_tg=[];
for i=1:size(dist,1)
    for j=1:size(dist,2)
        ss_initial=[ss_initial,ss{i,j}(1,2)]; 
        trend_mg=[trend_mg,trend(dist{i,j}(:,1))];
        trend_tg=[trend_tg,trend(dist{i,j}(:,2))];
    end
end


H_mg=[]; H_tg=[]; val=[];
for i=0:9
    ind=find(ss_initial>0.1*i&ss_initial<=0.1*(i+1));
    if ~isempty(ind)
        val=[val,0.1*i+0.05];
        H_mg=[H_mg,[length(find(trend_mg(ind)==1));length(find(trend_mg(ind)==2));length(find(trend_mg(ind)==3));length(find(trend_mg(ind)==4))]...
            ./length(ind)];
        H_tg=[H_tg,[length(find(trend_tg(ind)==1));length(find(trend_tg(ind)==2));length(find(trend_tg(ind)==3));length(find(trend_tg(ind)==4))]...
            ./length(ind)];
    end

end
figure;hold on;set(gcf,'unit','centimeters','position',[2,2,10,8]);
b=bar(val,H_mg','stack');
b(1).FaceColor=[255 146 106]./255;
b(2).FaceColor=[189 126 255]./255;
b(3).FaceColor=[238 42 123]./255;
b(4).FaceColor=[0 0 0]./255;
xlabel('mG* saturation level');ylabel('d(DoRA metric (Distance))/dmGAP');
xlim([0 1])

figure;hold on;set(gcf,'unit','centimeters','position',[2,2,10,8]);
b=bar(val,H_tg','stack');
b(1).FaceColor=[255 146 106]./255;
b(2).FaceColor=[189 126 255]./255;
b(3).FaceColor=[238 42 123]./255;
b(4).FaceColor=[0 0 0]./255;
xlabel('mG* saturation level');ylabel('d(DoRA metric (Distance))/dmGAP');
xlim([0 1])



%% plot DoRA metric vs mG level (the bottom panel in Figure 3B)
load server_mass_and.mat

dist_mg=[]; dist_tg=[]; ss_mg=[]; 
for i=1:length(kmG_all)
    for j=1:length(ktG_all)
        dist_mg=[dist_mg;dist{i,j}(:,1)];
        dist_tg=[dist_tg;dist{i,j}(:,2)];
        ss_mg=[ss_mg;ss{i,j}(:,2)];
    end
end

figure;hold on;set(gcf,'unit','centimeters','position',[2,2,10,8]);
me=[];plot(ss_mg,dist_mg,'o','color',[0 141 255]/255,'linewidth',0.25)
for i=0:1:9
    ind=find(ss_mg>0.1*i & ss_mg<=0.1*(i+1));
    errorbar(i*0.1+0.05,mean(dist_mg(ind)),std(dist_mg(ind)),'CapSize',18,'linewidth',1,'color','r');
    me=[me,mean(dist_mg(ind))];
end
plot(0.05:0.1:0.95,me,'r--'); xlabel('mG* saturation level');ylabel('DoRA metric (Distance)');
ylim([0 0.6]);set(gca,'ytick',0:0.3:0.6)


figure;hold on;set(gcf,'unit','centimeters','position',[2,2,10,8]);
me=[];plot(ss_mg,dist_tg,'o','color',[0 176 80]./255,'linewidth',0.25)
for i=0:1:9
    ind=find(ss_mg>0.1*i & ss_mg<=0.1*(i+1));
    errorbar(i*0.1+0.05,mean(dist_tg(ind)),std(dist_tg(ind)),'CapSize',18,'linewidth',1,'color','r');
    me=[me,mean(dist_tg(ind))];
end
plot(0.05:0.1:0.95,me,'r--'); xlabel('mG* saturation level');ylabel('DoRA metric (Distance)');



%% plot mG DoRA metric vs tG DoRA metric (right panel in Figure 5B)
load server_mass_and

dist_mg=[]; dist_tg=[]; ss_mg=[]; 
for i=1:length(kmG_all)
    for j=1:length(ktG_all)
        dist_mg=[dist_mg;dist{i,j}(:,1)];
        dist_tg=[dist_tg;dist{i,j}(:,2)];
        ss_mg=[ss_mg;ss{i,j}(:,2)];
    end
end

mg_interval=0:0.05:1;  

col= interp1([0 1],[1 1 1;[199 46 49]./255],linspace(0,1,length(mg_interval)+2),'linear');
col= col(3:end,:);
figure;hold on;set(gcf,'unit','centimeters','position',[2,2,10,8]);
for k=2:length(mg_interval)
    ind=find( ss_mg<=mg_interval(k)& ss_mg>=mg_interval(k-1));
    if ~isempty(ind)
        plot(dist_mg(ind),dist_tg(ind),'o','markersize',4,...
              'markerfacecolor',col(k,:),'linewidth',0.3,'markeredgecolor','none');
     end
end
axis([0 0.55 0 0.55])
plot([ 0 0.55 ],[0 0.55]);set(gca,'xtick',[0 0.55]);set(gca,'ytick',[0 0.55])
colormap(col);colorbar;



%%  compare AND and OR logic (Figure 4A)
load server_mass_and
dist_and=dist;  ss_and=ss;

load or_logic/server_mass_or
dist_or=dist;   ss_or=ss;

Val_all=linspace(0,1,15);

col= interp1([0 1],[1 1 1;[199 46 49]./255],linspace(0,1,21),'linear');
col= col(2:end,:);

mg_bin=0:0.03:1;
s=1;
figure;hold on;set(gcf,'unit','centimeters','position',[0,1,20,16]);  
for cc=1:2
    subplot(2,2,cc);hold on;   s1=0;n1=0;  s2=0;n2=0;
    for i=1:1:2:size(dist,1)
        for j=1:2:size(dist,2)
            s1_temp=ss_and{i,j}(:,2);
            s2_temp= ss_or{i,j}(:,2);

            d1_temp=dist_and{i,j}(:,cc);
            d2_temp= dist_or{i,j}(:,cc);

            for k=2:length(mg_bin)
                ind1=find( s1_temp<=mg_bin(k)& s1_temp>=mg_bin(k-1));
                ind2=find( s2_temp<=mg_bin(k)& s2_temp>=mg_bin(k-1));
                               
                if ~isempty(ind1)&~isempty(ind2)
                    for p=(length(Val_all)):-1:2
                            if Val_all(p)>=s1_temp(ind1(1)) &Val_all(p-1)<=s1_temp(ind1(1))
                                break;
                            end
                    end
                    plot(d1_temp(ind1(1)),d2_temp(ind2(1)),'o','markersize',8,...
                              'markerfacecolor',col(p,:),'linewidth',0.3,'markeredgecolor','none');
                    if d2_temp(ind2(1))<d1_temp(ind1(1))
                        s1=s1+abs(d2_temp(ind2(1))-d1_temp(ind1(1)))/sqrt(2);
                        n1=n1+1;
                    end
                    if d2_temp(ind2(1))>d1_temp(ind1(1))
                        s2=s2+abs(d2_temp(ind2(1))-d1_temp(ind1(1)))/sqrt(2);
                        n2=n2+1;
                    end       
                end 
            end

        end
    end
    axis([0 0.6 0 0.6]);
    plot([0 0.6],[0 0.6],'-')
    x=0:0.01:0.5;plot(x,x-sqrt(2)*s1/n1);
    x=0:0.01:0.5;plot(x,x+sqrt(2)*s2/n2);
    set(gca,'xtick',0:0.2:0.6);set(gca,'ytick',0:0.2:0.6)
end

