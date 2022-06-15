
function dC=fun_mass_action(t,C,S,kon_R,koff_R,kon_mGEF,koff_mGEF,kon_mGAP,koff_mGAP,kon_mG,koff_mG,...
            kon_tGEF,koff_tGEF,tGAP_ss,kon_tG,koff_tG,Tot,n)
% Description: This funciton defines the equations for the mass action model in the absence of negative feedback 




R    = C(1);
mGEF = C(2);
mGAP = C(3);  
mG   = C(4);

% if flag==1
% 
%     dC = [    kR*S*(Tot- R)     - koff*R;
%               kon*R              - koff*mGEF;
%              mGAP_ss             - koff*mGAP;
%              kmG*mGEF*(Tot-mG)   - koff*mGAP*mG];
% end
     


    tGEF = C(5);
    tG   = C(6);
    dC =[     kon_R    * S * (Tot- R)   - koff_R     *  R;
              kon_mGEF *R               - koff_mGEF  *  mGEF;
              kon_mGAP                  - koff_mGAP  *  mGAP;
              kon_mG   * mGEF* (Tot-mG) - koff_mG    *  mGAP*mG
              kon_tGEF * mG             - koff_tGEF  *  tGEF
              kon_tG   * tGEF* (Tot-tG) - koff_tG    *  tGAP_ss * tG];

end


