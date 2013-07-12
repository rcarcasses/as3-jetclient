/**
 * Created with IntelliJ IDEA.
 * @author Robert Carcasses Quevedo
 * Date: 7/8/13
 * Time: 7:12 PM
 */
package gambias.jetclient.protocols.impl
{
    import gambias.jetclient.codecs.impl.AMF3Deserializer;
    import gambias.jetclient.codecs.impl.AMF3Serializer;
    import gambias.jetclient.codecs.impl.LengthFieldBasedFrameDecoder;
    import gambias.jetclient.codecs.impl.LengthFieldPrepender;

    public class AMF3Protocol extends SimpleProtocol
    {
        public function AMF3Protocol()
        {
            _decoders = new Array();
            _coders = new Array();

            _coders.push(new AMF3Serializer());
            _coders.push(new LengthFieldPrepender());

            _decoders.push(new LengthFieldBasedFrameDecoder());
            _decoders.push(new AMF3Deserializer());
        }
    }
}
