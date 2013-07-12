package gambias.jetclient.codecs.impl
{
    import flash.utils.ByteArray;

    import gambias.jetclient.codecs.ITransform;

    /**
     * Whenever a message is sent to remote jetserver the length of the number of bytes
     * needs to be prepended to the message. This encoder will do that. It will accept a
     * byte array, find its length, create another byte array of the form <length><orginial byte array>
     * and return it. Normally this is the last encoder before a message is written to a socket.
     * @author Abraham Menacherry
     */
    public class LengthFieldPrepender implements ITransform
    {
        public function transform(input:Object):Object
        {
            //trace('[INFO][LengthFieldPrepender:transform()] Prepending length to', ByteArrayHexDump.dump(input as ByteArray));
            var buffer:ByteArray = new ByteArray;
            buffer.writeShort(ByteArray(input).length);
            buffer.writeBytes(ByteArray(input));
            return buffer;
        }
    }
}