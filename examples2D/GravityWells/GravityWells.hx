import flints.common.counters.Blast;
import flints.common.initializers.ColorInit;
import flints.twod.actions.GravityWell;
import flints.twod.actions.Move;
import flints.twod.emitters.Emitter2D;
import flints.twod.initializers.Position;
import flints.twod.zones.DiscZone;
import openfl.geom.Point;

class GravityWells extends Emitter2D
{

  public function new()
  {
    super ();

    counter = new Blast(10000);
    addInitializer(new ColorInit(0xFFFF00FF, 0xFF00FFFF));
    addInitializer(new Position(new DiscZone(new Point(200, 200), 200)));
    addAction(new Move());
    addAction(new GravityWell(25, 200, 200));
    addAction(new GravityWell(25, 75, 75));
    addAction(new GravityWell(25, 325, 325));
    addAction(new GravityWell(25, 75, 325));
    addAction(new GravityWell(25, 325, 75));
  }

}

