package gambias.jetclient.codecs.impl
{
    import flash.utils.ByteArray;

    import gambias.jetclient.codecs.ITransform;

    /**
     * Converts an incoming JetEvent into a ByteArray. It will read the event type from the
     * JetEvent. Then it will serialize the payload an object to byte array. Both the event
     * type and serialized bytes are written to a byte array and send to next encoder in the chain.
     * @author Abraham Menacherry
     */
    public class AMF3Serializer implements ITransform
    {
        /**
         * Encodes the input in AMF format.
         * @param input The actionscript object to encode.
         * @return  The ByteArray which is the AMF representation of the object.
         */
        public function transform(input:Object):Object
        {
            //trace('[INFO][AMFSerializer:transform()] Transforming', input);
            if (input == null)
            {
                trace('[WARN][AMFSerializer:transform()] Null object passed to AMF serializer');
                throw new Error("null isn't a legal serialization candidate");
                return null;
            }

            var bytes:ByteArray = new ByteArray();
            bytes.writeObject(input);
            return bytes;
        }
    }
}