
function dC=fun_Hill_or(t,C,S,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
            kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,kfeedback,Tot,n)
% Description: This function is the same as fun_mass_or except the kinetic forms 



EC=0.5; 

R    = C(1);
mGEF = C(2);
mGAP = C(3);  
mG   = C(4);



tGEF = C(5);
tG   = C(6);
dC =[     kon_R * f_act(EC,n,S)* (Tot- R)         - koff_R     *  R;
          kon_mGEF *f_act(EC,n,R)                 - koff_mGEF  *  mGEF;
          kon_mGAP+kfeedback*(f_act(EC,n,tG)+f_act(EC,n,tGEF)) - koff_mGAP  *  mGAP;
          kon_mG   *f_act(EC,n,mGEF)* (Tot-mG)    - koff_mG    *  f_act(EC,n,mGAP)*mG
          kon_tGEF * f_act(EC,n,mG)               - koff_tGEF  *  tGEF
          kon_tG   * f_act(EC,n,tGEF)* (Tot-tG)   - koff_tG    *  f_act(EC,n,tGAP_ss) * tG];

end



function y=f_act(EC,n,x)

y=real(x^n)/real(x^n+EC^n);


end

