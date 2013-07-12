/**
 * Created with IntelliJ IDEA.
 * @author Robert Carcasses Quevedo
 * Date: 7/10/13
 * Time: 11:42 PM
 */



package gambias.jetclient.event
{

    import flash.events.Event;

    public class SocketDataEvent extends Event
    {
        public static const NEW_DATA:String = 'newSocketData';

        public var payload:Object;

        public function SocketDataEvent()
        {
            super(NEW_DATA);
        }

        public static function getSocketDataEvent(source:Object):SocketDataEvent
        {
            var event:SocketDataEvent = new SocketDataEvent();
            event.payload = source;
            return event;
        }
    }
}
