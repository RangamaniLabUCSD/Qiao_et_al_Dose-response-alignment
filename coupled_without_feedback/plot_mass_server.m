set(0,'DefaultLineLineWidth',1);
set(0,'DefaultAxesFontSize',20,'DefaultAxesFontWeight','bold');
set(0,'DefaultTextFontSize',20,'DefaultTextFontWeight','bold');


%% plot DoRA trend vs mG level(the middle panel in Figure 2B)
load server_mass_mGAP

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
xlim([0.2 1])

figure;hold on;set(gcf,'unit','centimeters','position',[2,2,10,8]);
b=bar(val,H_tg','stack');
b(1).FaceColor=[255 146 106]./255;
b(2).FaceColor=[189 126 255]./255;
b(3).FaceColor=[238 42 123]./255;
b(4).FaceColor=[0 0 0]./255;
xlabel('mG* saturation level');ylabel('d(DoRA metric (Distance))/dmGAP');
xlim([0.2 1])



%% plot DoRA metric vs mG level(the bottom panel in Figure 2B)
load server_mass_mGAP

dist_mg=[]; dist_tg=[]; ss_mg=[]; 
for i=1:2:length(kmG_all)
    for j=1:2:length(ktG_all)
        dist_mg=[dist_mg;dist{i,j}(:,1)];
        dist_tg=[dist_tg;dist{i,j}(:,2)];
        ss_mg=[ss_mg;ss{i,j}(:,2)];
    end
end

figure;hold on;set(gcf,'unit','centimeters','position',[2,2,10,8]);
plot(ss_mg,dist_mg,'ob','linewidth',0.25); 
xlabel('mG* saturation level');ylabel('DoRA metric (Distance)');
x=linspace(min(ss_mg),max(ss_mg),20);
[C,ia]=unique(ss_mg);plot(x,interp1(C,dist_mg(ia),x),'r--','linewidth',0.5)


figure;hold on;set(gcf,'unit','centimeters','position',[2,2,10,8]);
me=[];plot(ss_mg,dist_tg,'o','color',[0 176 80]./255,'linewidth',0.25)
for i=0:1:9
    ind=find(ss_mg>0.1*i & ss_mg<=0.1*(i+1));
    errorbar(i*0.1+0.05,mean(dist_tg(ind)),std(dist_tg(ind)),'CapSize',18,'linewidth',1,'color','r');
    me=[me,mean(dist_tg(ind))];
end
plot(0.05:0.1:0.95,me,'r--'); xlabel('mG* saturation level');ylabel('DoRA metric (Distance)');



%% plot mG DoRA metric vs tG DoRA metric (left panel in Figure 5B)
load server_mass_mGAP

dist_mg=[]; dist_tg=[]; ss_mg=[]; 
for i=1:2:length(kmG_all)
    for j=1:2:length(ktG_all)
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
