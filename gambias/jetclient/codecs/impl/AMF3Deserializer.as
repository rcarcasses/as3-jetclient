package gambias.jetclient.codecs.impl
{
    import flash.utils.ByteArray;

    import gambias.jetclient.codecs.ITransform;

    /**
     * This decoder will convert an incoming ByteArray into a JetEvent. It will first read the opcode
     * byte to see which kind of event is coming from remote jetserver, say SESSION_MESSAGE and it will
     * read the payload into an object using byte array's readObject method.
     * @author Abraham Menacherry
     */
    public class AMF3Deserializer implements ITransform
    {
        /**
         * Returns an Object store in the AMF ByteArray passed.
         * @param input The ByteArray with the AMF representation of the Object.
         * @return  The encoded Object.
         */
        public function transform(input:Object):Object
        {
            //trace('[INFO][AMFDeserializer:transform()] Transforming\n', ByteArrayHexDump.dump(input as ByteArray));
            //reset the ByteArray position so we can read the entire object from AMF.
            ByteArray(input).position = 0;
            return ByteArray(input).readObject();
        }
    }
}