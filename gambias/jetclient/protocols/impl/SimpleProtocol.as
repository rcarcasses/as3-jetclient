/**
 * Created with IntelliJ IDEA.
 * @author Robert Carcasses Quevedo
 * Date: 7/8/13
 * Time: 6:11 PM
 */
package gambias.jetclient.protocols.impl
{
    import flash.utils.ByteArray;

    import gambias.jetclient.codecs.ITransform;

    import gambias.jetclient.codecs.impl.LengthFieldBasedFrameDecoder;

    import gambias.jetclient.codecs.impl.LengthFieldPrepender;

    import gambias.jetclient.protocols.IProtocol;

    /**
     * The simplest protocol: reads the length of the game
     * packet and returns the payload.
     */
    public class SimpleProtocol implements IProtocol {
        /**
         * This array contains the decoders to be applied to an input.
         */
        protected var _decoders:Array;
        /**
         * This contains the coders to be applied to an object in
         * order to serialize it and make it ready to be send through the
         * socket connection.
         */
        protected var _coders:Array;

        /**
         * This simple protocol has only one encoder (LengthFieldPrepender)
         * and one decoder (LengthFieldBasedFrameDecoder). To build a new protocol
         * most of the cases is enough to extends from this class and
         * to add the custom codecs to the pipelines.
         */
        public function SimpleProtocol()
        {
            _decoders = new Array();
            _coders = new Array();

            _coders.push(new LengthFieldPrepender());
            _decoders.push(new LengthFieldBasedFrameDecoder());

        }

        public function read(input:ByteArray, readCallback:Function):void
        {
            /**
             * As we may potentially get two commands in a single TCP packet
             * we have to decode as long as we get results from decoding
             */
            var done:Boolean = false;
            input.position = 0;
            trace('[INFO][SimpleProtocol:read()] Input bytesAvailables', input.bytesAvailable, 'position', input.position);

            var result:Object = input;
            trace('[INFO][SimpleProtocol:read()] Reading input');
            while (!done)
            {
                for (var i:int = 0; i < _decoders.length; i++)
                {
                    var decoder:ITransform = _decoders[i];
                    result = decoder.transform(result);

                    if (result == null)
                    {
                        done = true;
                        trace('[INFO][SimpleProtocol:read()] Done');
                        break;
                    }
                }

                if (result != null)
                    readCallback(result);

                //next iteration is with an empty ByteArray
                //we don't pass anything to the pipeline, so we
                //can get the remaining bytes information
                result = new ByteArray();
            }
        }

        /**
         * This function assumes a ByteArray as input if we only have the LengthFieldPrepender coder
         * in the _coders Array.
         * @param input The Object to encode.
         * @return The ByteArray with the Object encoded on it. The last element in the
         * chain should return a ByteArray.
         */
        public function write(input:Object):ByteArray
        {
            trace('[INFO][SimpleProtocol:write()] Writing object', input);
            var result:Object = input;
            for (var i:int = 0; i < _coders.length; i++)
            {
                var coder:ITransform = _coders[i];
                result = coder.transform(result);
            }

            return result as ByteArray;
        }
    }
}
