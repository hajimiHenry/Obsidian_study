settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(700);
import three;

currentprojection = perspective(8, 3, 3.5);

// Axes
draw(O--4.2X, arrow=Arrow3(), L=Label("$x$", position=EndPoint));
draw(O--4.2Y, arrow=Arrow3(), L=Label("$y$", position=EndPoint));
draw(O--4.2Z, arrow=Arrow3(), L=Label("$z$", position=EndPoint));
label("$O$", O, SW);

real R = 3;
real dr = 0.8;
real theta1 = 55;
real dtheta = 20;
real phi1 = 30;
real dphi = 20;

real theta2 = theta1 + dtheta;
real phi2 = phi1 + dphi;

triple P(real r, real ph, real th) {
    return (r*Sin(ph)*Cos(th), r*Sin(ph)*Sin(th), r*Cos(ph));
}

triple P111 = P(R, phi1, theta1);
triple P211 = P(R+dr, phi1, theta1);
triple P121 = P(R, phi2, theta1);
triple P221 = P(R+dr, phi2, theta1);
triple P112 = P(R, phi1, theta2);
triple P212 = P(R+dr, phi1, theta2);
triple P122 = P(R, phi2, theta2);
triple P222 = P(R+dr, phi2, theta2);

path3 edge_dr1 = P111--P211;
path3 edge_dr2 = P121--P221;
path3 edge_dr3 = P112--P212;
path3 edge_dr4 = P122--P222;

path3 edge_dphi1 = arc(O, P111, P121, cross(P111, P121));
path3 edge_dphi2 = arc(O, P211, P221, cross(P211, P221));
path3 edge_dphi3 = arc(O, P112, P122, cross(P112, P122));
path3 edge_dphi4 = arc(O, P212, P222, cross(P212, P222));

triple C1 = (0, 0, R*Cos(phi1));
triple C2 = (0, 0, (R+dr)*Cos(phi1));
triple C3 = (0, 0, R*Cos(phi2));
triple C4 = (0, 0, (R+dr)*Cos(phi2));

path3 edge_dtheta1 = arc(C1, P111, P112, Z);
path3 edge_dtheta2 = arc(C2, P211, P212, Z);
path3 edge_dtheta3 = arc(C3, P121, P122, Z);
path3 edge_dtheta4 = arc(C4, P221, P222, Z);

// Draw outlines
draw(edge_dr1, red+2.0);
draw(edge_dr2, black+0.8);
draw(edge_dr3, black+0.8);
draw(edge_dr4, black+0.8);

draw(edge_dphi1, blue+2.0);
draw(edge_dphi2, black+0.8);
draw(edge_dphi3, black+0.8);
draw(edge_dphi4, black+0.8);

draw(edge_dtheta1, darkgreen+2.0);
draw(edge_dtheta2, black+0.8);
draw(edge_dtheta3, black+0.8);
draw(edge_dtheta4, black+0.8);

// Labels for the three edges
label("$dr$", (P111+P211)/2, SE, red);

triple mid_dphi1 = unit(P111+P121) * (R - 0.2);
label("$r\,d\varphi$", mid_dphi1, NW, blue);

triple mid_dtheta1 = C1 + unit(P111-C1 + P112-C1) * R * Sin(phi1);
label("$r\sin\varphi\,d\theta$", mid_dtheta1, N, darkgreen);

// Show the connection to origin
draw(O--P111, dashed+black+0.6);
draw(O--P121, dashed+black+0.6);
draw(O--P112, dashed+black+0.6);

// Angles at origin
triple mid_dphi_angle = 1.0*unit(unit(P111)+unit(P121));
path3 arc_dphi = arc(O, 1.0*unit(P111), 1.0*unit(P121), cross(P111, P121));
draw(arc_dphi, black+0.8);
label("$d\varphi$", mid_dphi_angle, W);

// Horizontal plane angle dtheta
triple Pxy111 = (P111.x, P111.y, 0);
triple Pxy112 = (P112.x, P112.y, 0);
draw(O--Pxy111, dashed+black+0.6);
draw(O--Pxy112, dashed+black+0.6);
draw(P111--Pxy111, dashed+black+0.6);
draw(P112--Pxy112, dashed+black+0.6);

triple mid_dtheta_angle = 1.8*unit(unit(Pxy111)+unit(Pxy112));
path3 arc_dtheta = arc(O, 1.8*unit(Pxy111), 1.8*unit(Pxy112), Z);
draw(arc_dtheta, black+0.8);
label("$d\theta$", mid_dtheta_angle, E);

// Draw radius on the horizontal plane
draw(C1--P111, dashed+magenta+0.8);
label("$r\sin\varphi$", (C1+P111)/2, S, magenta);
