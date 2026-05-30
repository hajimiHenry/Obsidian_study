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

// Parameters
real R = 3.5;
real theta = 60;
real phi = 40;

real Px = R*Sin(phi)*Cos(theta);
real Py = R*Sin(phi)*Sin(theta);
real Pz = R*Cos(phi);
triple P = (Px, Py, Pz);

// P
dot(P, red+linewidth(6));
label("$P(x,y,z)$", P, N, red);

// Step 1: r and phi, and z
draw(O--P, red+1.2, arrow=Arrow3());
label("$r$", O + 0.6*P, NW, red);

triple phi_start = 1.0 * Z;
triple phi_end = 1.0 * unit(P);
path3 arc_phi = arc(O, phi_start, phi_end, cross(Z, P));
draw(arc_phi, black+1.0, arrow=Arrow3());
label("$\varphi$", 1.0 * unit(phi_start + phi_end), E);

triple Pz_point = (0, 0, Pz);
draw(P--Pz_point, dashed+black+0.8);
dot(Pz_point, black+linewidth(4));
label("$z = r\cos\varphi$", Pz_point, NW);

// Step 2: horizontal distance
triple Pxy = (Px, Py, 0);
draw(P--Pxy, dashed+black+0.8);
draw(Pz_point--P, dashed+black+0.8); 
draw(O--Pxy, blue+1.2, arrow=Arrow3());
label("$r\sin\varphi$", O + 0.5*Pxy, NW, blue);

// Draw right angle for horizontal distance
real s = 0.3;
draw((Pz_point + s*unit(P-Pz_point))--(Pz_point + s*unit(P-Pz_point) - s*Z)--(Pz_point - s*Z), black+0.8);

// Step 3: decompose in xy plane
triple Px_point = (Px, 0, 0);
triple Py_point = (0, Py, 0);

draw(Pxy--Px_point, dashed+black+0.8);
draw(Pxy--Py_point, dashed+black+0.8);
draw(O--Px_point, darkgreen+1.2, arrow=Arrow3());
draw(O--Py_point, darkgreen+1.2, arrow=Arrow3());

dot(Px_point, black+linewidth(4));
dot(Py_point, black+linewidth(4));
label("$x = r\sin\varphi\cos\theta$", Px_point, S);
label("$y = r\sin\varphi\sin\theta$", Py_point, SE);

// theta
triple theta_start = 1.5 * X;
triple theta_end = 1.5 * unit(Pxy);
path3 arc_theta = arc(O, theta_start, theta_end, Z);
draw(arc_theta, black+1.0, arrow=Arrow3());
label("$\theta$", 1.5 * unit(theta_start + theta_end), NE);
