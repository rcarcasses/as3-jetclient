/**
 * Created with IntelliJ IDEA.
 * @author Robert Carcasses Quevedo
 * Date: 7/9/13
 * Time: 12:43 PM
 */
package test
{
    import flash.display.Sprite;

    import gambias.jetclient.JetClient;
    import gambias.jetclient.event.SocketDataEvent;
    import gambias.jetclient.protocols.impl.AMF3Protocol;

    public class NadronConnectionTest extends Sprite
    {
        private var _client:JetClient;
        public function NadronConnectionTest()
        {

            _client = new JetClient('localhost', 18090, new AMF3Protocol());
            _client.addEventListener(SocketDataEvent.NEW_DATA, logedIn);
            _client.connect('robert', 'asfasfdsdf', 'asdfasdfa2l34jhkjjbwqk412b3b4nbdpiuypas9sd-9fa0s8 12-qdfasdf9a-0-23rqwefasdfasd');
        }

        private function logedIn(event:SocketDataEvent):void
        {
            //remove so we don't enter in a loop
            _client.removeEventListener(SocketDataEvent.NEW_DATA, logedIn);

            //do a new call
            trace('[INFO][NadronConnectionTest:logedIn()] Loged in, sending some stuff');
            var newMessage:Object = {type:1,payload:{number:78}};
            _client.sendObject(newMessage);
        }
    }
}
