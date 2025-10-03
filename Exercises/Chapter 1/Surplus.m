function [ub, ua, sp] = Surplus(g,r)

ub = -exp(0.5.* r.^2);
ua = -exp(-r.*g).*cdf('Normal',g,0,1)-exp(0.5.*(r.^2)).*(1-cdf('Normal',g+r,0,1))./(1./(1-cdf('Normal',g,0,1))) .*(1-cdf('Normal',g,0,1));
sp = ua - ub;

return
