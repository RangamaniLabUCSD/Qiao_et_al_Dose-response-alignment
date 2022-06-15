function flag=trend(temp)
% This function is to obtain the trend of DoRA metric

cc=diff(temp);
flag=0;
if isempty(find(cc>0))  % decreasing
    flag=1;       %fill([i i+1 i+1 i],[j j j+1 j+1],[255 146 106]./255,'edgecolor','k');
end
if  isempty(find(cc<0))  % increasing
    flag=2;       % fill([i i+1 i+1 i],[j j j+1 j+1],[58 191 0]./255,'edgecolor','k');
end
if ~isempty(find(cc<0))&&~isempty(find(cc>0))  % decreasing first and then increasing 
    ind1=find(cc<=0); ind2=find(cc>0);
    if max(ind1)<=min(ind2)
       flag=3;    %fill([i i+1 i+1 i],[j j j+1 j+1],[21 182 255]./255,'edgecolor','k');
    end
end
if ~isempty(find(cc<0))&&~isempty(find(cc>0))   % increasing first and then decreasing 
    ind1=find(cc>0); ind2=find(cc<=0); 
    if max(ind1)<=min(ind2)
      flag=4;      % fill([i i+1 i+1 i],[j j j+1 j+1],'k','edgecolor','k');
    end
end
end             