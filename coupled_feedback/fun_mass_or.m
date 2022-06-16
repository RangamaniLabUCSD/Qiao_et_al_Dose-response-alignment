
function dC=fun_mass_or(t,C,S,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
            kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,kfeedback,Tot,n)
% Description: This funciton defines the equations for the mass action model in the presence of negative feedback 
% and the negative feedback is modeled by OR logic




R    = C(1);
mGEF = C(2);
mGAP = C(3);  
mG   = C(4);


tGEF = C(5);
tG   = C(6);
dC =[     kon_R    * S * (Tot- R)   - koff_R     *  R;
          kon_mGEF *R               - koff_mGEF  *  mGEF;
        kon_mGAP+kfeedback*(tG+tGEF)- koff_mGAP  *  mGAP;
          kon_mG   * mGEF* (Tot-mG) - koff_mG    *  mGAP*mG
          kon_tGEF * mG             - koff_tGEF  *  tGEF
          kon_tG   * tGEF* (Tot-tG) - koff_tG    *  tGAP_ss * tG];
end


