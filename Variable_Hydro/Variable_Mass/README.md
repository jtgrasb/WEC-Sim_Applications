# Variable Hydro - Sphere with variable mass

**Author:**	Jeff Grasberger

**Version:** 	WEC-Sim version (e.g. v6.1.2)

**Geometry:**	Sphere

**Dependency:**	N/A

This application demonstrates using WEC-Sim's variable hydrodynamics advanced feature to model a sphere with a changing mass.
The sphere's mass is set-up to change instantaneously every 100 seconds. 
This model requires a broken library link--WEC-Sim does not support this model with a varying mass.
To recreate: duplicate the changes within sphereVarMass/Float/Hydrodynamic Body/Structure
