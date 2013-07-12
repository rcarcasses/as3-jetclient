/**
 * Created with IntelliJ IDEA.
 * @author Robert Carcasses Quevedo
 * Date: 7/8/13
 * Time: 11:12 PM
 */
package test
{
    import flash.display.Sprite;
    import flash.utils.ByteArray;

    import gambias.jetclient.protocols.impl.AMF3Protocol;

    import utils.ByteArrayHexDump;

    public class SocketProtocolTest extends Sprite
    {
        public function SocketProtocolTest()
        {
            var obj:Object = {name:'Robert', id:989898988989898/*, date:new Date()*/};
            var protocol:AMF3Protocol = new AMF3Protocol();
            var objEncoded:ByteArray = protocol.write(obj);
            trace('[INFO][SocketProtocolTest:SocketProtocolTest()] Object encoded dump');
            trace(ByteArrayHexDump.dump(objEncoded));
            protocol.read(objEncoded, objectDecoded);

            trace('[INFO][SocketProtocolTest:SocketProtocolTest()] Fragmentation test');
            trace('-')
            trace('-')
            trace('-')
            trace('-')
            trace('-')
            trace('-')
            //now we can test if it works for fragmented data
            objEncoded.position = 0;
            var frag1:ByteArray = new ByteArray();
            frag1.writeBytes(objEncoded, 0, 3);
            trace('[INFO][SocketProtocolTest:SocketProtocolTest()] Frag1', ByteArrayHexDump.dump(frag1));
            var frag2:ByteArray = new ByteArray();
            frag2.writeBytes(objEncoded, 3, 10);
            trace('[INFO][SocketProtocolTest:SocketProtocolTest()] Frag2', ByteArrayHexDump.dump(frag2));
            var frag3:ByteArray = new ByteArray();
            frag3.writeBytes(objEncoded, 13);
            trace('[INFO][SocketProtocolTest:SocketProtocolTest()] Frag3', ByteArrayHexDump.dump(frag3));



            protocol.read(frag1, objectDecoded);
            protocol.read(frag2, objectDecoded);
            protocol.read(frag3, objectDecoded);

            trace('[INFO][SocketProtocolTest:SocketProtocolTest()] Fragmentation and clustering test');
            var obj1:Object = {name:'Robert', id:989898988989898/*, date:new Date()*/};
            var objEncoded1:ByteArray = protocol.write(obj1);
            var obj2:Object = {name:'Gambias', id:"revolution", friends:[1,2,3,31,1,3], cash:100};
            var objEncoded2:ByteArray = protocol.write(obj2);
            var obj3:Object = {id:"allo", friends:['john', 'taylor', 'lucy'], credits:100};
            var objEncoded3:ByteArray = protocol.write(obj3);
            objEncoded1.position = 0;
            objEncoded2.position = 0;
            objEncoded3.position = 0;

            //fragment the first
            var f1:ByteArray = new ByteArray();
            f1.writeBytes(objEncoded1, 0, 5);

            //put the rest in the second and two objects more
            var f2:ByteArray = new ByteArray();
            f2.writeBytes(objEncoded1, 5);
            f2.writeBytes(objEncoded2);
            f2.writeBytes(objEncoded3);

            //proceed to decode
            protocol.read(f1, objectDecoded);
            protocol.read(f2, objectDecoded);
        }

        private function objectDecoded(result:Object):void
        {
            trace('[INFO][SocketProtocolTest:objectDecoded()] Object decoded', JSON.stringify(result));
        }
    }
}
