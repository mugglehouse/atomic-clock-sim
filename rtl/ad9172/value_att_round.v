/*******************************************************************************************
 * FileProperties:
 *     FileName: value_att_round.v
 *     SvnProperties:
 *         $URL: http://192.168.0.155/svn/PR1104/PRIVATE/17_FPGAPrj_for_VIVADO/HQGF_4D_DRFMJ5G/branches/mode0/src/top/value_att_round.v
 *         $Author: lianming $
 *         $Revision: 18593 $
 *         $Date: 2020年5月31日 19:20:11 周一
*******************************************************************************************/

module value_att_round#(
  parameter                          IN_WIDTH  = 16,
                                     OUT_WIDTH = 16	
)
( 
  input                              reset            ,
  input                              clk              ,
   
  input signed [ IN_WIDTH-1   :0]    value_in         ,
  input       [14:0]                 value_multip     ,// 
  input        [9:0]                 value_0p1db_att  ,//0.0 to 60.2dB  
  output reg  signed [OUT_WIDTH-1:0] value_out        
);

reg  signed [15:0]              value_multip_reg    ;
reg  signed [15:0]              value_multip_reg_d1 ;
reg  signed [15:0]              value_multip_reg_d2 ;  
  
reg  signed [ IN_WIDTH+16-1:0]  value_multip_result ;   
reg  signed [OUT_WIDTH     :0]  value_out_sum       ;  

always@(posedge clk or posedge reset)
begin
  if(reset)
    begin
      value_multip_reg_d1 <= 15'b0;
      value_multip_reg_d2 <= 15'b0;
    end
  else
    begin
      value_multip_reg_d1 <= value_multip_reg;
      value_multip_reg_d2 <= value_multip_reg_d1;
    end
end

always@(posedge clk or posedge reset)
begin
	if(reset)
	  begin
	  	value_multip_reg <= 0; 
	  end
  else 
   case(value_0p1db_att)                  
    //0.0 to 9.9 000-099
    10'd000:value_multip_reg = 32767;
    10'd001:value_multip_reg = 32393;
    10'd002:value_multip_reg = 32022; 
    10'd003:value_multip_reg = 31656; 
    10'd004:value_multip_reg = 31293; 
    10'd005:value_multip_reg = 30935; 
    10'd006:value_multip_reg = 30581; 
    10'd007:value_multip_reg = 30231;
    10'd008:value_multip_reg = 29885; 
    10'd009:value_multip_reg = 29543;                                     
    10'd010:value_multip_reg = 29205; 
    10'd011:value_multip_reg = 28870; 
    10'd012:value_multip_reg = 28540; 
    10'd013:value_multip_reg = 28213; 
    10'd014:value_multip_reg = 27890; 
    10'd015:value_multip_reg = 27571; 
    10'd016:value_multip_reg = 27255; 
    10'd017:value_multip_reg = 26943; 
    10'd018:value_multip_reg = 26635; 
    10'd019:value_multip_reg = 26330; 
    10'd020:value_multip_reg = 26029; 
    10'd021:value_multip_reg = 25731; 
    10'd022:value_multip_reg = 25436; 
    10'd023:value_multip_reg = 25145; 
    10'd024:value_multip_reg = 24857; 
    10'd025:value_multip_reg = 24573; 
    10'd026:value_multip_reg = 24291; 
    10'd027:value_multip_reg = 24013; 
    10'd028:value_multip_reg = 23738; 
    10'd029:value_multip_reg = 23467; 
    10'd030:value_multip_reg = 23198; 
    10'd031:value_multip_reg = 22932; 
    10'd032:value_multip_reg = 22670; 
    10'd033:value_multip_reg = 22410; 
    10'd034:value_multip_reg = 22154; 
    10'd035:value_multip_reg = 21900; 
    10'd036:value_multip_reg = 21650; 
    10'd037:value_multip_reg = 21402; 
    10'd038:value_multip_reg = 21157; 
    10'd039:value_multip_reg = 20915; 
    10'd040:value_multip_reg = 20675; 
    10'd041:value_multip_reg = 20439; 
    10'd042:value_multip_reg = 20205; 
    10'd043:value_multip_reg = 19973; 
    10'd044:value_multip_reg = 19745; 
    10'd045:value_multip_reg = 19519; 
    10'd046:value_multip_reg = 19295; 
    10'd047:value_multip_reg = 19074; 
    10'd048:value_multip_reg = 18856; 
    10'd049:value_multip_reg = 18640; 
    10'd050:value_multip_reg = 18427; 
    10'd051:value_multip_reg = 18216; 
    10'd052:value_multip_reg = 18007; 
    10'd053:value_multip_reg = 17801; 
    10'd054:value_multip_reg = 17597; 
    10'd055:value_multip_reg = 17396; 
    10'd056:value_multip_reg = 17197; 
    10'd057:value_multip_reg = 17000; 
    10'd058:value_multip_reg = 16805; 
    10'd059:value_multip_reg = 16613; 
    10'd060:value_multip_reg = 16423; 
    10'd061:value_multip_reg = 16235; 
    10'd062:value_multip_reg = 16049; 
    10'd063:value_multip_reg = 15865; 
    10'd064:value_multip_reg = 15684; 
    10'd065:value_multip_reg = 15504; 
    10'd066:value_multip_reg = 15327; 
    10'd067:value_multip_reg = 15151; 
    10'd068:value_multip_reg = 14978; 
    10'd069:value_multip_reg = 14806; 
    10'd070:value_multip_reg = 14637; 
    10'd071:value_multip_reg = 14469; 
    10'd072:value_multip_reg = 14304; 
    10'd073:value_multip_reg = 14140; 
    10'd074:value_multip_reg = 13978; 
    10'd075:value_multip_reg = 13818; 
    10'd076:value_multip_reg = 13660; 
    10'd077:value_multip_reg = 13504; 
    10'd078:value_multip_reg = 13349; 
    10'd079:value_multip_reg = 13196; 
    10'd080:value_multip_reg = 13045; 
    10'd081:value_multip_reg = 12896; 
    10'd082:value_multip_reg = 12748; 
    10'd083:value_multip_reg = 12602; 
    10'd084:value_multip_reg = 12458; 
    10'd085:value_multip_reg = 12315; 
    10'd086:value_multip_reg = 12174; 
    10'd087:value_multip_reg = 12035; 
    10'd088:value_multip_reg = 11897; 
    10'd089:value_multip_reg = 11761; 
    10'd090:value_multip_reg = 11627; 
    10'd091:value_multip_reg = 11493; 
    10'd092:value_multip_reg = 11362; 
    10'd093:value_multip_reg = 11232; 
    10'd094:value_multip_reg = 11103; 
    10'd095:value_multip_reg = 10976; 
    10'd096:value_multip_reg = 10851; 
    10'd097:value_multip_reg = 10726; 
    10'd098:value_multip_reg = 10604; 
    10'd099:value_multip_reg = 10482; 
    //10.0 to 19.9 100-199
    10'd100:value_multip_reg = 10362;
    10'd101:value_multip_reg = 10244;
    10'd102:value_multip_reg = 10126; 
    10'd103:value_multip_reg = 10010; 
    10'd104:value_multip_reg = 9896 ; 
    10'd105:value_multip_reg = 9783 ; 
    10'd106:value_multip_reg = 9671 ; 
    10'd107:value_multip_reg = 9560 ;
    10'd108:value_multip_reg = 9450 ; 
    10'd109:value_multip_reg = 9342 ;                                     
    10'd110:value_multip_reg = 9235 ; 
    10'd111:value_multip_reg = 9130 ; 
    10'd112:value_multip_reg = 9025 ; 
    10'd113:value_multip_reg = 8922 ; 
    10'd114:value_multip_reg = 8820 ; 
    10'd115:value_multip_reg = 8719 ; 
    10'd116:value_multip_reg = 8619 ; 
    10'd117:value_multip_reg = 8520 ; 
    10'd118:value_multip_reg = 8423 ; 
    10'd119:value_multip_reg = 8326 ; 
    10'd120:value_multip_reg = 8231 ; 
    10'd121:value_multip_reg = 8137 ; 
    10'd122:value_multip_reg = 8044 ; 
    10'd123:value_multip_reg = 7952 ; 
    10'd124:value_multip_reg = 7860 ; 
    10'd125:value_multip_reg = 7771 ; 
    10'd126:value_multip_reg = 7682 ; 
    10'd127:value_multip_reg = 7594 ; 
    10'd128:value_multip_reg = 7507 ; 
    10'd129:value_multip_reg = 7421 ; 
    10'd130:value_multip_reg = 7336 ; 
    10'd131:value_multip_reg = 7252 ; 
    10'd132:value_multip_reg = 7169 ; 
    10'd133:value_multip_reg = 7087 ; 
    10'd134:value_multip_reg = 7006 ; 
    10'd135:value_multip_reg = 6925 ; 
    10'd136:value_multip_reg = 6846 ; 
    10'd137:value_multip_reg = 6768 ; 
    10'd138:value_multip_reg = 6690 ; 
    10'd139:value_multip_reg = 6614 ; 
    10'd140:value_multip_reg = 6538 ; 
    10'd141:value_multip_reg = 6463 ; 
    10'd142:value_multip_reg = 6389 ; 
    10'd143:value_multip_reg = 6316 ; 
    10'd144:value_multip_reg = 6244 ; 
    10'd145:value_multip_reg = 6172 ; 
    10'd146:value_multip_reg = 6102 ; 
    10'd147:value_multip_reg = 6032 ; 
    10'd148:value_multip_reg = 5963 ; 
    10'd149:value_multip_reg = 5895 ; 
    10'd150:value_multip_reg = 5827 ; 
    10'd151:value_multip_reg = 5760 ; 
    10'd152:value_multip_reg = 5694 ; 
    10'd153:value_multip_reg = 5629 ; 
    10'd154:value_multip_reg = 5565 ; 
    10'd155:value_multip_reg = 5501 ; 
    10'd156:value_multip_reg = 5438 ; 
    10'd157:value_multip_reg = 5376 ; 
    10'd158:value_multip_reg = 5314 ; 
    10'd159:value_multip_reg = 5254 ; 
    10'd160:value_multip_reg = 5193 ; 
    10'd161:value_multip_reg = 5134 ; 
    10'd162:value_multip_reg = 5075 ; 
    10'd163:value_multip_reg = 5017 ; 
    10'd164:value_multip_reg = 4960 ; 
    10'd165:value_multip_reg = 4903 ; 
    10'd166:value_multip_reg = 4847 ; 
    10'd167:value_multip_reg = 4791 ; 
    10'd168:value_multip_reg = 4736 ; 
    10'd169:value_multip_reg = 4682 ; 
    10'd170:value_multip_reg = 4629 ; 
    10'd171:value_multip_reg = 4576 ; 
    10'd172:value_multip_reg = 4523 ; 
    10'd173:value_multip_reg = 4471 ; 
    10'd174:value_multip_reg = 4420 ; 
    10'd175:value_multip_reg = 4370 ; 
    10'd176:value_multip_reg = 4320 ; 
    10'd177:value_multip_reg = 4270 ; 
    10'd178:value_multip_reg = 4221 ; 
    10'd179:value_multip_reg = 4173 ; 
    10'd180:value_multip_reg = 4125 ; 
    10'd181:value_multip_reg = 4078 ; 
    10'd182:value_multip_reg = 4031 ; 
    10'd183:value_multip_reg = 3985 ; 
    10'd184:value_multip_reg = 3940 ; 
    10'd185:value_multip_reg = 3894 ; 
    10'd186:value_multip_reg = 3850 ; 
    10'd187:value_multip_reg = 3806 ; 
    10'd188:value_multip_reg = 3762 ; 
    10'd189:value_multip_reg = 3719 ; 
    10'd190:value_multip_reg = 3677 ; 
    10'd191:value_multip_reg = 3635 ; 
    10'd192:value_multip_reg = 3593 ; 
    10'd193:value_multip_reg = 3552 ; 
    10'd194:value_multip_reg = 3511 ; 
    10'd195:value_multip_reg = 3471 ; 
    10'd196:value_multip_reg = 3431 ; 
    10'd197:value_multip_reg = 3392 ; 
    10'd198:value_multip_reg = 3353 ; 
    10'd199:value_multip_reg = 3315 ; 
    //20.0 to 29.9 200-299
    10'd200:value_multip_reg = 3277 ;
    10'd201:value_multip_reg = 3239;
    10'd202:value_multip_reg = 3202; 
    10'd203:value_multip_reg = 3166; 
    10'd204:value_multip_reg = 3129; 
    10'd205:value_multip_reg = 3093; 
    10'd206:value_multip_reg = 3058; 
    10'd207:value_multip_reg = 3023;
    10'd208:value_multip_reg = 2988; 
    10'd209:value_multip_reg = 2954;                                     
    10'd210:value_multip_reg = 2920; 
    10'd211:value_multip_reg = 2887; 
    10'd212:value_multip_reg = 2854; 
    10'd213:value_multip_reg = 2821; 
    10'd214:value_multip_reg = 2789; 
    10'd215:value_multip_reg = 2757; 
    10'd216:value_multip_reg = 2726; 
    10'd217:value_multip_reg = 2694; 
    10'd218:value_multip_reg = 2663; 
    10'd219:value_multip_reg = 2633; 
    10'd220:value_multip_reg = 2603; 
    10'd221:value_multip_reg = 2573; 
    10'd222:value_multip_reg = 2544; 
    10'd223:value_multip_reg = 2514; 
    10'd224:value_multip_reg = 2486; 
    10'd225:value_multip_reg = 2457; 
    10'd226:value_multip_reg = 2429; 
    10'd227:value_multip_reg = 2401; 
    10'd228:value_multip_reg = 2374; 
    10'd229:value_multip_reg = 2347; 
    10'd230:value_multip_reg = 2320; 
    10'd231:value_multip_reg = 2293; 
    10'd232:value_multip_reg = 2267; 
    10'd233:value_multip_reg = 2241; 
    10'd234:value_multip_reg = 2215; 
    10'd235:value_multip_reg = 2190; 
    10'd236:value_multip_reg = 2165; 
    10'd237:value_multip_reg = 2140; 
    10'd238:value_multip_reg = 2116; 
    10'd239:value_multip_reg = 2091; 
    10'd240:value_multip_reg = 2068; 
    10'd241:value_multip_reg = 2044; 
    10'd242:value_multip_reg = 2020; 
    10'd243:value_multip_reg = 1997; 
    10'd244:value_multip_reg = 1974; 
    10'd245:value_multip_reg = 1952; 
    10'd246:value_multip_reg = 1930; 
    10'd247:value_multip_reg = 1907; 
    10'd248:value_multip_reg = 1886; 
    10'd249:value_multip_reg = 1864; 
    10'd250:value_multip_reg = 1843; 
    10'd251:value_multip_reg = 1822; 
    10'd252:value_multip_reg = 1801; 
    10'd253:value_multip_reg = 1780; 
    10'd254:value_multip_reg = 1760; 
    10'd255:value_multip_reg = 1740; 
    10'd256:value_multip_reg = 1720; 
    10'd257:value_multip_reg = 1700; 
    10'd258:value_multip_reg = 1681; 
    10'd259:value_multip_reg = 1661; 
    10'd260:value_multip_reg = 1642; 
    10'd261:value_multip_reg = 1623; 
    10'd262:value_multip_reg = 1605; 
    10'd263:value_multip_reg = 1587; 
    10'd264:value_multip_reg = 1568; 
    10'd265:value_multip_reg = 1550; 
    10'd266:value_multip_reg = 1533; 
    10'd267:value_multip_reg = 1515; 
    10'd268:value_multip_reg = 1498; 
    10'd269:value_multip_reg = 1481; 
    10'd270:value_multip_reg = 1464; 
    10'd271:value_multip_reg = 1447; 
    10'd272:value_multip_reg = 1430; 
    10'd273:value_multip_reg = 1414; 
    10'd274:value_multip_reg = 1398; 
    10'd275:value_multip_reg = 1382; 
    10'd276:value_multip_reg = 1366; 
    10'd277:value_multip_reg = 1350; 
    10'd278:value_multip_reg = 1335; 
    10'd279:value_multip_reg = 1320; 
    10'd280:value_multip_reg = 1305; 
    10'd281:value_multip_reg = 1290; 
    10'd282:value_multip_reg = 1275; 
    10'd283:value_multip_reg = 1260; 
    10'd284:value_multip_reg = 1246; 
    10'd285:value_multip_reg = 1232; 
    10'd286:value_multip_reg = 1217; 
    10'd287:value_multip_reg = 1204; 
    10'd288:value_multip_reg = 1190; 
    10'd289:value_multip_reg = 1176; 
    10'd290:value_multip_reg = 1163; 
    10'd291:value_multip_reg = 1149; 
    10'd292:value_multip_reg = 1136; 
    10'd293:value_multip_reg = 1123; 
    10'd294:value_multip_reg = 1110; 
    10'd295:value_multip_reg = 1098; 
    10'd296:value_multip_reg = 1085; 
    10'd297:value_multip_reg = 1073; 
    10'd298:value_multip_reg = 1060; 
    10'd299:value_multip_reg = 1048; 
    //30.0 to 39.9 300-399
    10'd300:value_multip_reg = 1036 ;
    10'd301:value_multip_reg = 1024;
    10'd302:value_multip_reg = 1013; 
    10'd303:value_multip_reg = 1001; 
    10'd304:value_multip_reg = 990 ; 
    10'd305:value_multip_reg = 978 ; 
    10'd306:value_multip_reg = 967 ; 
    10'd307:value_multip_reg = 956 ;
    10'd308:value_multip_reg = 945 ; 
    10'd309:value_multip_reg = 934 ;                                     
    10'd310:value_multip_reg = 924 ; 
    10'd311:value_multip_reg = 913 ; 
    10'd312:value_multip_reg = 903 ; 
    10'd313:value_multip_reg = 892 ; 
    10'd314:value_multip_reg = 882 ; 
    10'd315:value_multip_reg = 872 ; 
    10'd316:value_multip_reg = 862 ; 
    10'd317:value_multip_reg = 852 ; 
    10'd318:value_multip_reg = 842 ; 
    10'd319:value_multip_reg = 833 ; 
    10'd320:value_multip_reg = 823 ; 
    10'd321:value_multip_reg = 814 ; 
    10'd322:value_multip_reg = 804 ; 
    10'd323:value_multip_reg = 795 ; 
    10'd324:value_multip_reg = 786 ; 
    10'd325:value_multip_reg = 777 ; 
    10'd326:value_multip_reg = 768 ; 
    10'd327:value_multip_reg = 759 ; 
    10'd328:value_multip_reg = 751 ; 
    10'd329:value_multip_reg = 742 ; 
    10'd330:value_multip_reg = 734 ; 
    10'd331:value_multip_reg = 725 ; 
    10'd332:value_multip_reg = 717 ; 
    10'd333:value_multip_reg = 709 ; 
    10'd334:value_multip_reg = 701 ; 
    10'd335:value_multip_reg = 693 ; 
    10'd336:value_multip_reg = 685 ; 
    10'd337:value_multip_reg = 677 ; 
    10'd338:value_multip_reg = 669 ; 
    10'd339:value_multip_reg = 661 ; 
    10'd340:value_multip_reg = 654 ; 
    10'd341:value_multip_reg = 646 ; 
    10'd342:value_multip_reg = 639 ; 
    10'd343:value_multip_reg = 632 ; 
    10'd344:value_multip_reg = 624 ; 
    10'd345:value_multip_reg = 617 ; 
    10'd346:value_multip_reg = 610 ; 
    10'd347:value_multip_reg = 603 ; 
    10'd348:value_multip_reg = 596 ; 
    10'd349:value_multip_reg = 589 ; 
    10'd350:value_multip_reg = 583 ; 
    10'd351:value_multip_reg = 576 ; 
    10'd352:value_multip_reg = 569 ; 
    10'd353:value_multip_reg = 563 ; 
    10'd354:value_multip_reg = 556 ; 
    10'd355:value_multip_reg = 550 ; 
    10'd356:value_multip_reg = 544 ; 
    10'd357:value_multip_reg = 538 ; 
    10'd358:value_multip_reg = 531 ; 
    10'd359:value_multip_reg = 525 ; 
    10'd360:value_multip_reg = 519 ; 
    10'd361:value_multip_reg = 513 ; 
    10'd362:value_multip_reg = 508 ; 
    10'd363:value_multip_reg = 502 ; 
    10'd364:value_multip_reg = 496 ; 
    10'd365:value_multip_reg = 490 ; 
    10'd366:value_multip_reg = 485 ; 
    10'd367:value_multip_reg = 479 ; 
    10'd368:value_multip_reg = 474 ; 
    10'd369:value_multip_reg = 468 ; 
    10'd370:value_multip_reg = 463 ; 
    10'd371:value_multip_reg = 458 ; 
    10'd372:value_multip_reg = 452 ; 
    10'd373:value_multip_reg = 447 ; 
    10'd374:value_multip_reg = 442 ; 
    10'd375:value_multip_reg = 437 ; 
    10'd376:value_multip_reg = 432 ; 
    10'd377:value_multip_reg = 427 ; 
    10'd378:value_multip_reg = 422 ; 
    10'd379:value_multip_reg = 417 ; 
    10'd380:value_multip_reg = 413 ; 
    10'd381:value_multip_reg = 408 ; 
    10'd382:value_multip_reg = 403 ; 
    10'd383:value_multip_reg = 399 ; 
    10'd384:value_multip_reg = 394 ; 
    10'd385:value_multip_reg = 389 ; 
    10'd386:value_multip_reg = 385 ; 
    10'd387:value_multip_reg = 381 ; 
    10'd388:value_multip_reg = 376 ; 
    10'd389:value_multip_reg = 372 ; 
    10'd390:value_multip_reg = 368 ; 
    10'd391:value_multip_reg = 363 ; 
    10'd392:value_multip_reg = 359 ; 
    10'd393:value_multip_reg = 355 ; 
    10'd394:value_multip_reg = 351 ; 
    10'd395:value_multip_reg = 347 ; 
    10'd396:value_multip_reg = 343 ; 
    10'd397:value_multip_reg = 339 ; 
    10'd398:value_multip_reg = 335 ; 
    10'd399:value_multip_reg = 331 ; 
    //40.0 to 49.9 400-499   
    10'd400:value_multip_reg = 328 ;
    10'd401:value_multip_reg = 324;
    10'd402:value_multip_reg = 320; 
    10'd403:value_multip_reg = 317; 
    10'd404:value_multip_reg = 313; 
    10'd405:value_multip_reg = 309; 
    10'd406:value_multip_reg = 306; 
    10'd407:value_multip_reg = 302;
    10'd408:value_multip_reg = 299; 
    10'd409:value_multip_reg = 295;                                     
    10'd410:value_multip_reg = 292; 
    10'd411:value_multip_reg = 289; 
    10'd412:value_multip_reg = 285; 
    10'd413:value_multip_reg = 282; 
    10'd414:value_multip_reg = 279; 
    10'd415:value_multip_reg = 276; 
    10'd416:value_multip_reg = 273; 
    10'd417:value_multip_reg = 269; 
    10'd418:value_multip_reg = 266; 
    10'd419:value_multip_reg = 263; 
    10'd420:value_multip_reg = 260; 
    10'd421:value_multip_reg = 257; 
    10'd422:value_multip_reg = 254; 
    10'd423:value_multip_reg = 251; 
    10'd424:value_multip_reg = 249; 
    10'd425:value_multip_reg = 246; 
    10'd426:value_multip_reg = 243; 
    10'd427:value_multip_reg = 240; 
    10'd428:value_multip_reg = 237; 
    10'd429:value_multip_reg = 235; 
    10'd430:value_multip_reg = 232; 
    10'd431:value_multip_reg = 229; 
    10'd432:value_multip_reg = 227; 
    10'd433:value_multip_reg = 224; 
    10'd434:value_multip_reg = 222; 
    10'd435:value_multip_reg = 219; 
    10'd436:value_multip_reg = 216; 
    10'd437:value_multip_reg = 214; 
    10'd438:value_multip_reg = 212; 
    10'd439:value_multip_reg = 209; 
    10'd440:value_multip_reg = 207; 
    10'd441:value_multip_reg = 204; 
    10'd442:value_multip_reg = 202; 
    10'd443:value_multip_reg = 200; 
    10'd444:value_multip_reg = 197; 
    10'd445:value_multip_reg = 195; 
    10'd446:value_multip_reg = 193; 
    10'd447:value_multip_reg = 191; 
    10'd448:value_multip_reg = 189; 
    10'd449:value_multip_reg = 186; 
    10'd450:value_multip_reg = 184; 
    10'd451:value_multip_reg = 182; 
    10'd452:value_multip_reg = 180; 
    10'd453:value_multip_reg = 178; 
    10'd454:value_multip_reg = 176; 
    10'd455:value_multip_reg = 174; 
    10'd456:value_multip_reg = 172; 
    10'd457:value_multip_reg = 170; 
    10'd458:value_multip_reg = 168; 
    10'd459:value_multip_reg = 166; 
    10'd460:value_multip_reg = 164; 
    10'd461:value_multip_reg = 162; 
    10'd462:value_multip_reg = 160; 
    10'd463:value_multip_reg = 159; 
    10'd464:value_multip_reg = 157; 
    10'd465:value_multip_reg = 155; 
    10'd466:value_multip_reg = 153; 
    10'd467:value_multip_reg = 152; 
    10'd468:value_multip_reg = 150; 
    10'd469:value_multip_reg = 148; 
    10'd470:value_multip_reg = 146; 
    10'd471:value_multip_reg = 145; 
    10'd472:value_multip_reg = 143; 
    10'd473:value_multip_reg = 141; 
    10'd474:value_multip_reg = 140; 
    10'd475:value_multip_reg = 138; 
    10'd476:value_multip_reg = 137; 
    10'd477:value_multip_reg = 135; 
    10'd478:value_multip_reg = 133; 
    10'd479:value_multip_reg = 132; 
    10'd480:value_multip_reg = 130; 
    10'd481:value_multip_reg = 129; 
    10'd482:value_multip_reg = 127; 
    10'd483:value_multip_reg = 126; 
    10'd484:value_multip_reg = 125; 
    10'd485:value_multip_reg = 123; 
    10'd486:value_multip_reg = 122; 
    10'd487:value_multip_reg = 120; 
    10'd488:value_multip_reg = 119; 
    10'd489:value_multip_reg = 118; 
    10'd490:value_multip_reg = 116; 
    10'd491:value_multip_reg = 115; 
    10'd492:value_multip_reg = 114; 
    10'd493:value_multip_reg = 112; 
    10'd494:value_multip_reg = 111; 
    10'd495:value_multip_reg = 110; 
    10'd496:value_multip_reg = 109; 
    10'd497:value_multip_reg = 107; 
    10'd498:value_multip_reg = 106; 
    10'd499:value_multip_reg = 105; 
    10'd500:value_multip_reg = 104; 
    
    10'd542:value_multip_reg = 64 ;     
    10'd550:value_multip_reg = 58 ;
    10'd600:value_multip_reg = 33 ;
    10'd602:value_multip_reg = 32 ; 
    10'd650:value_multip_reg = 18 ;     
    10'd660:value_multip_reg = 16 ;    
    10'd700:value_multip_reg = 10 ; 
    10'd720:value_multip_reg = 8  ;  
    10'd750:value_multip_reg = 6  ;        
    10'd800:value_multip_reg = 3  ; 
    10'd840:value_multip_reg = 2  ; 
    10'd850:value_multip_reg = 2  ;         
    10'd900:value_multip_reg = 1  ;   
    10'd1023:value_multip_reg = {1'b0,value_multip[14:00]}; //3ff        
    default :value_multip_reg  = 0          ;   
   endcase
end  

always@(posedge clk or posedge reset)
begin
	if(reset)
	  begin
	  	value_multip_result <= 0; 
	  	value_out_sum       <= 0; 
	  	value_out           <= 0;
	  end
  else
   begin
  	 value_multip_result <= value_in * value_multip_reg_d2;
// below :round fuction for signed value  
  	 value_out_sum       <= value_multip_result[IN_WIDTH+16-1:IN_WIDTH+16-1-OUT_WIDTH] +1 ;
   	 value_out           <= value_out_sum      [OUT_WIDTH-1:0]    ; 	
   end
end   
   
endmodule
