function ss=resp_curve(C0,S_all,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
            kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,Tot,fun,n,var_name,range)

ss=zeros(length(S_all),length(C0));
eval([var_name,'=range;']);

for j=1:length(S_all)              
        S =S_all(j);
        [TT,Y]  = ode23s(@(t,C) fun(t,C,S,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
            kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,Tot,n),[0 100000000],C0);
        %[TT,Y]  = ode23s(@(t,C) fun_mass_action(t,C,S,para,flag,kR,kmG,ktG),[0 10000],C0);  %figure;plot(TT,Y)
        ss(j,:) = Y(end,:);            
end