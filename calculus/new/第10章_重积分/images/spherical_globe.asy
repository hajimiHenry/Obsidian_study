settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import three;

currentprojection = perspective(6, 2.5, 3);

// Axes
draw(O--4X, arrow=Arrow3(), L=Label("$x$", position=EndPoint));
draw(O--4Y, arrow=Arrow3(), L=Label("$y$", position=EndPoint));
draw(O--4Z, arrow=Arrow3(), L=Label("$z$", position=EndPoint));
label("$O$", O, SW);

// Sphere
real R = 3;
surface sph = scale3(R)*unitsphere;
draw(sph, lightblue+opacity(0.2));

// Equator
path3 equator = scale3(R)*unitcircle3;
draw(equator, dashed+blue+0.8);

// Meridians/Silhouettes
path3 arcxz = arc(O, R*Z, R*X, Y) & arc(O, R*X, -R*Z, Y) & arc(O, -R*Z, -R*X, Y) & arc(O, -R*X, R*Z, Y) & cycle;
draw(arcxz, blue+0.4);
path3 arcyz = arc(O, R*Z, R*Y, X) & arc(O, R*Y, -R*Z, X) & arc(O, -R*Z, -R*Y, X) & arc(O, -R*Y, R*Z, X) & cycle;
draw(arcyz, blue+0.4);

// Point P
real theta = 55;
real phi = 35;
real Px = R*Sin(phi)*Cos(theta);
real Py = R*Sin(phi)*Sin(theta);
real Pz = R*Cos(phi);
triple P = (Px, Py, Pz);

dot(P, red+linewidth(6));
label("$P(r, \varphi, \theta)$", P, NE, red);

// r vector
draw(O--P, red+1.2, arrow=Arrow3());
label("$r$", O + 0.5*P, NW, red);

// phi angle
triple phi_start = 1.0 * Z;
triple phi_end = 1.0 * unit(P);
path3 arc_phi = arc(O, phi_start, phi_end, cross(Z, P));
draw(arc_phi, black+1.0, arrow=Arrow3());
label("$\varphi$", 1.0 * unit(phi_start + phi_end), E);

// P projection on xy plane
triple Pxy = (Px, Py, 0);
draw(P--Pxy, dashed+black+0.8);
draw(O--Pxy, dashed+black+0.8);

// theta angle
triple theta_start = 1.5 * X;
triple theta_end = 1.5 * unit(Pxy);
path3 arc_theta = arc(O, theta_start, theta_end, Z);
draw(arc_theta, black+1.0, arrow=Arrow3());
label("$\theta$", 1.5 * unit(theta_start + theta_end), SE);

// Poles and equator labels
dot(R*Z, blue+linewidth(4));
label("$\varphi=0$", R*Z, N, blue);

dot(-R*Z, blue+linewidth(4));
label("$\varphi=\pi$", -R*Z, S, blue);

label("$\varphi=\pi/2$", R*unit(X+Y), SE, blue);

// Text
label("$r \in [0, R]$", (0, -4.5, 3), red);
