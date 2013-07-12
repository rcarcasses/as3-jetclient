/**
 * Created with IntelliJ IDEA.
 * @author Robert Carcasses Quevedo
 * Date: 7/8/13
 * Time: 6:03 PM
 */
package gambias.jetclient.protocols {
    import flash.utils.ByteArray;

    public interface IProtocol {
    /**
     * Reads a ByteArray and transform it to a useful Object.
     * @param input The ByteArray coming from the socket.
     * @param readCallback Whenever a new packet (game packet, not TCP packet) is
     * read the readCallback function is called with the final ByteArray
     */
    function read(input:ByteArray, readCallback:Function):void

    /**
     * Writes an object through the socket connection.
     * The protocol implementation should take care of the
     * proper serialization of the Object.
     * @param input The Object to serialize.
     * @return A ByteArray ready to be send through the socket.
     */
    function write(input:Object):ByteArray
}
}
