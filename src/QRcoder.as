package
{
	import com.google.zxing.BarcodeFormat;
	import com.google.zxing.BinaryBitmap;
	import com.google.zxing.BufferedImageLuminanceSource;
	import com.google.zxing.DecodeHintType;
	import com.google.zxing.Result;
	import com.google.zxing.client.result.ParsedResult;
	import com.google.zxing.client.result.ResultParser;
	import com.google.zxing.common.GlobalHistogramBinarizer;
	import com.google.zxing.common.flexdatatypes.HashTable;
	import com.google.zxing.qrcode.QRCodeReader;
	
	import flash.display.BitmapData;

	public class QRcoder
	{
		public function QRcoder()
		{
		}
		
		public static function getStringCode(bmd:BitmapData):String
		{
			var _qrCodeData:String;
			var _qrCodeReader:QRCodeReader=new QRCodeReader;
			//_bitmapData转换到BufferedImageLuminanceSource。
			var bufferedImageLum : BufferedImageLuminanceSource = new BufferedImageLuminanceSource( bmd );
			var binaryBmp : BinaryBitmap = new BinaryBitmap( new GlobalHistogramBinarizer( bufferedImageLum ) );
			
			var hashTable : HashTable = new HashTable();
			hashTable.Add( DecodeHintType.POSSIBLE_FORMATS, BarcodeFormat.QR_CODE );
			var result : Result;
			try {
				// 解码
				result = _qrCodeReader.decode( binaryBmp, hashTable );
			} catch (event:Error) { 
				trace("error")
			}
			if ( result) {
				//this.currentState = 'error';
				var parsedResult : ParsedResult = ResultParser.parseResult( result );
				_qrCodeData = parsedResult.getDisplayResult();
			} 
			return _qrCodeData;
		}
	}
}