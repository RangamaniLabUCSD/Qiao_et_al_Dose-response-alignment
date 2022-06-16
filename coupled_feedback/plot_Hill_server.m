% scatter
set(0,'DefaultLineLineWidth',1);
set(0,'DefaultAxesFontSize',20,'DefaultAxesFontWeight','bold');
set(0,'DefaultTextFontSize',20,'DefaultTextFontWeight','bold');

%% plot DoRA trend vs mG level(the middle panel in Figure 2D)
load server_Hill_tG_0dot01_mGAP; dist_ktG0dot01=dist;  ss_ktG0dot01=ss;

load server_Hill_tG_1_mGAP;  dist_ktG1=dist;  ss_ktG1=ss;

load server_Hill_tG_10_mGAP; dist_ktG10=dist; ss_ktG10=ss;


var_name_d={'dist_ktG0dot01','dist_ktG1','dist_ktG10'};
var_name_s={'ss_ktG0dot01','ss_ktG1','ss_ktG10'};
ss_initial=[];  trend_mg=[]; trend_tg=[];
for i=1:size(dist,1)
    for j=1:size(dist,2)
        for k=1:3
            eval(['dist=',var_name_d{k},';']);
            eval(['ss=',var_name_s{k},';']);
            ss_initial=[ss_initial,ss{i,j}(1,2)]; 
            trend_mg=[trend_mg,trend(dist{i,j}(:,1))];
            trend_tg=[trend_tg,trend(dist{i,j}(:,2))];
        end
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




%% plot DoRA metric vs mG level(the bottom panel in Figure 2D)
var_name_d={'dist_ktG0dot01','dist_ktG1','dist_ktG10'};
var_name_s={'ss_ktG0dot01','ss_ktG1','ss_ktG10'};
dist_mg=[]; dist_tg=[]; ss_mg=[]; 
for i=1:size(dist,1)
    for j=1:size(dist,2)
        for k=1:3
            eval(['temp_d=',var_name_d{k},';']);
            eval(['temp_s=',var_name_s{k},';']);
            dist_mg=[dist_mg;temp_d{i,j}(:,1)];
            dist_tg=[dist_tg;temp_d{i,j}(:,2)];
            ss_mg=[ss_mg;temp_s{i,j}(:,2)];
        end
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
ylim([0 0.5]);set(gca,'ytick',0:0.25:0.5)


figure;hold on;set(gcf,'unit','centimeters','position',[2,2,10,8]);
me=[];plot(ss_mg,dist_tg,'o','color',[0 176 80]./255,'linewidth',0.25)
for i=0:1:9
    ind=find(ss_mg>0.1*i & ss_mg<=0.1*(i+1));
    errorbar(i*0.1+0.05,mean(dist_tg(ind)),std(dist_tg(ind)),'CapSize',18,'linewidth',1,'color','r');
    me=[me,mean(dist_tg(ind))];
end
plot(0.05:0.1:0.95,me,'r--'); xlabel('mG* saturation level');ylabel('DoRA metric (Distance)');
ylim([0 0.5]);set(gca,'ytick',0:0.25:0.5)





%% plot mG DoRA metric vs tG DoRA metric (left panel in Figure 5D)
set(0,'DefaultLineLineWidth',1);
set(0,'DefaultAxesFontSize',20,'DefaultAxesFontWeight','bold');
set(0,'DefaultTextFontSize',20,'DefaultTextFontWeight','bold');


load server_Hill_tG_0dot01_mGAP; dist_ktG0dot01=dist;  ss_ktG0dot01=ss;

load server_Hill_tG_1_mGAP;  dist_ktG1=dist;  ss_ktG1=ss;

load server_Hill_tG_10_mGAP; dist_ktG10=dist; ss_ktG10=ss;

var_name_d={'dist_ktG0dot01','dist_ktG1','dist_ktG10'};
var_name_s={'ss_ktG0dot01','ss_ktG1','ss_ktG10'};
dist_mg=[]; dist_tg=[]; ss_mg=[]; 
for i=1:size(dist,1)
    for j=1:size(dist,2)
        for k=1:3
            eval(['temp_d=',var_name_d{k},';']);
            eval(['temp_s=',var_name_s{k},';']);
            dist_mg=[dist_mg;temp_d{i,j}(:,1)];
            dist_tg=[dist_tg;temp_d{i,j}(:,2)];
            ss_mg=[ss_mg;temp_s{i,j}(:,2)];
        end
    end
end


mg_interval=0:0.05:1;  

col= interp1([0 1],[1 1 1;[199 46 49]./255],linspace(0,1,length(mg_interval)+2),'linear');
col= col(3:end,:);
figure;hold on;set(gcf,'unit','centimeters','position',[2,2,10,8]);
for k=2:length(mg_interval)
    ind=find( ss_mg<=mg_interval(k)& ss_mg>=mg_interval(k-1));
    if ~isempty(ind)
        plot(dist_mg(ind),dist_tg(ind),'o','markersize',8,...
              'markerfacecolor',col(k,:),'linewidth',0.3,'markeredgecolor','none');
     end
end
axis([0 0.55 0 0.55])
plot([ 0 0.55 ],[0 0.55])
colormap(col);colorbar;





