package gambias.jetclient.codecs.impl
{
    import flash.utils.ByteArray;

    import gambias.jetclient.codecs.ITransform;

    /**
     * A codec which can decode an incoming frame from remote jetserver based on the
     * length of the incoming bytes. Jetserver sends data in the form of <lenght 2 bytes>-<payload of message>.
     * This decoder will read the length of the payload, capture the payload and pass it on to
     * the next decoder in the chain as a ByteArray. If all the bytes are not available it will return <b>null</b>.
     * @author Abraham Menacherry
     */
    public class LengthFieldBasedFrameDecoder implements ITransform
    {
        private var _lengthFieldLength:int;
        private var _length:int;
        private var _buffer:ByteArray;

        public function LengthFieldBasedFrameDecoder(lengthFieldLength:int = 2)
        {
            _length = 0;
            _lengthFieldLength = lengthFieldLength;
            _buffer = new ByteArray();
        }

        /**
         * Reads the lenght of the game packet and tries to read the
         * payload. If the payload doesn't have all the bytes, then
         * it waits for the next call, add the new bytes to the existing
         * buffer, and tries again to get the payload.
         * If any bytes remain, they will be prepened to the next bytes
         * passed.
         * @param input A ByteArray coming from the server.
         * @return The payload of the game packet, null otherwise.
         */
        public function transform(input:Object):Object
        {
            //trace('[INFO][LengthFieldBasedFrameDecoder:transform()] Transforming', ByteArrayHexDump.dump(input as ByteArray), 'bytesAvaliables',  ByteArray(input).bytesAvailable);

            //copy all to the buffer, if there is something meaningfully
            input.position = 0;
            if (ByteArray(input).bytesAvailable > 0)
            {
                //set the position to the end of the buffer to add the next bytes there
                _buffer.position = _buffer.length;
                _buffer.writeBytes(input as ByteArray);
            }

            _buffer.position = 0;

            if(_buffer.length == 0)
                return null;

            _length = _buffer.readShort();

            if (_buffer.bytesAvailable < _length)
                return null;

            //if we reach here is because we can read the whole game packet
            var message:ByteArray = new ByteArray();
            _buffer.readBytes(message, 0, _length);

            //put the buffer ready for the next call
            resetBuffer();

            return message;
        }

        /**
         * Copies the remaining bytes into a new buffer.
         * The next time transform is called the remaining bytes will
         * be available.
         */
        private function resetBuffer():void
        {
            //creates a temporal byte array
            var remainingBytes:ByteArray = new ByteArray();
            //copy the remaining bytes to the temporal byte array
            _buffer.readBytes(remainingBytes);
            //reset the buffer
            _buffer = new ByteArray();
            //and write back the remaining bytes to the start of the buffer
            _buffer.writeBytes(remainingBytes);
        }

    }

}