<?php
namespace Org\Util\Kmc;
class pkg8583
{
    private $msgtypeid='';
    private $tpdu='';
    private $msghead='';
    private $txcode='';
    private $txdate='';
    private $txtime='';
    private $version='';
    private $field000='';
    private $field002='';
    private $field003='';
    private $field004='';
    private $field005='';
    private $field006='';
    private $field007='';
    private $field008='';
    private $field009='';
    private $field010='';
    private $field011='';
    private $field014='';
    private $field015='';
    private $field016='';
    private $field017='';
    private $field018='';
    private $field019='';
    private $field020='';
    private $field021='';
    private $field022='';
    private $field023='';
    private $field024='';
    private $field025='';
    private $field026='';
    private $field031='';
    private $field032='';
    private $field033='';
    private $field035='';
    private $field036='';
    private $field037='';
    private $field038='';
    private $field039='';
    private $field041='';
    private $field042='';
    private $field043='';
    private $field044='';
    private $field046='';
    private $field048='';
    private $field049='';
    private $field052='';
    private $field053='';
    private $field054='';
    private $field055='';
    private $field056='';
    private $field057='';
    private $field058='';
    private $field059='';
    private $field060='';
    private $field061='';
    private $field062='';
    private $field063='';
    private $field064='';
    private $field065='';
    private $field070='';
    private $field089='';
    private $field090='';
    private $field096='';
    private $field098='';
    private $field100='';
    private $field101='';
    private $field102='';
    private $field103='';
    private $field104='';
    private $field105='';
    private $field106='';
    private $field107='';
    private $field108='';
    private $field109='';
    private $field110='';
    private $field111='';
    private $field112='';
    private $field113='';
    private $field114='';
    private $field115='';
    private $field116='';
    private $field117='';
    private $field118='';
    private $field119='';
    private $field120='';
    private $field121='';
    private $field122='';
    private $field124='';
    private $field125='';
    private $field128='';
    
    public function __construct()
    {
        ;
    }
    
    
    public function getSignData()
    {
        $strb='';	
		if($this->txcode !="")
		  $strb=$strb.$this->txcode;
		if($this->txdate !="")
		  $strb=$strb.$this->txdate;
		if($this->txtime !="")
		  $strb=$strb.$this->txtime;
		if($this->version !="")
		  $strb=$strb.$this->version;
		if($this->field000 !="")
			$strb=$strb.$this->field000;
		if($this->field002 !="")
		  $strb=$strb.$this->field002;
		if($this->field003 !="")
		  $strb=$strb.$this->field003;
		if($this->field004 !="")
		  $strb=$strb.$this->field004;
		if($this->field005 !="")
		  $strb=$strb.$this->field005;
		if($this->field006 !="")
		  $strb=$strb.$this->field006;
		if($this->field007 !="")
		  $strb=$strb.$this->field007;
		if($this->field008 !="")
		  $strb=$strb.$this->field008;
		if($this->field009 !="")
		  $strb=$strb.$this->field009;
		if($this->field010 !="")
		  $strb=$strb.$this->field010;
		if($this->field011 !="")
		  $strb=$strb.$this->field011;
		if($this->field014 !="")
		  $strb=$strb.$this->field014;
		if($this->field015 !="")
		  $strb=$strb.$this->field015;
		if($this->field016 !="")
		  $strb=$strb.$this->field016;
		if($this->field017 !="")
		  $strb=$strb.$this->field017;
		if($this->field018 !="")
		  $strb=$strb.$this->field018;
		if($this->field019 !="")
		  $strb=$strb.$this->field019;
		if($this->field020 !="")
		  $strb=$strb.$this->field020;
		if($this->field021 !="")
		  $strb=$strb.$this->field021;
		if($this->field022 !="")
		  $strb=$strb.$this->field022;
		if($this->field023 !="")
		  $strb=$strb.$this->field023;
		if($this->field024 !="")
		  $strb=$strb.$this->field024;
		if($this->field025 !="")
		  $strb=$strb.$this->field025;
		if($this->field026 !="")
		  $strb=$strb.$this->field026;
		if($this->field031 !="")
		  $strb=$strb.$this->field031;
		if($this->field032 !="")
		  $strb=$strb.$this->field032;
		if($this->field033 !="")
		  $strb=$strb.$this->field033;
		if($this->field035 !="")
		  $strb=$strb.$this->field035;
		if($this->field036 !="")
		  $strb=$strb.$this->field036;
		if($this->field037 !="")
		  $strb=$strb.$this->field037;
		if($this->field038 !="")
		  $strb=$strb.$this->field038;
		if($this->field039 !="")
		$strb=$strb.$this->field039;
		if($this->field041 !="")
		$strb=$strb.$this->field041;
		if($this->field042 !="")
		$strb=$strb.$this->field042;
		if($this->field043 !="")
		$strb=$strb.$this->field043;
		if($this->field044 !="")
		$strb=$strb.$this->field044;
		if($this->field046 !="")
		$strb=$strb.$this->field046;
		if($this->field048 !="")
		$strb=$strb.$this->field048;
		if($this->field049 !="")
		$strb=$strb.$this->field049;
		if($this->field052 !="")
		$strb=$strb.$this->field052;
		if($this->field053 !="")
		$strb=$strb.$this->field053;
		if($this->field054 !="")
		$strb=$strb.$this->field054;
		if($this->field055 !="")
		$strb=$strb.$this->field055;
		if($this->field056 !="")
		$strb=$strb.$this->field056;
		if($this->field057 !="")
		$strb=$strb.$this->field057;
		if($this->field058 !="")
		$strb=$strb.$this->field058;
		if($this->field059 !="")
		$strb=$strb.$this->field059;
		if($this->field060 !="")
		$strb=$strb.$this->field060;
		if($this->field061 !="")
		$strb=$strb.$this->field061;
		if($this->field062 !="")
		$strb=$strb.$this->field062;
		if($this->field063 !="")
		$strb=$strb.$this->field063;
		if($this->field064 !="")
		$strb=$strb.$this->field064;
		if($this->field065 !="")
		$strb=$strb.$this->field065;
		if($this->field070 !="")
		$strb=$strb.$this->field070;
		if($this->field089 !="")
		$strb=$strb.$this->field089;
		if($this->field090 !="")
		$strb=$strb.$this->field090;
		if($this->field096 !="")
		$strb=$strb.$this->field096;
		if($this->field098 !="")
		$strb=$strb.$this->field098;
		if($this->field100 !="")
		$strb=$strb.$this->field100;
		if($this->field101 !="")
		$strb=$strb.$this->field101;
		if($this->field102 !="")
		$strb=$strb.$this->field102;
		if($this->field103 !="")
		$strb=$strb.$this->field103;
		if($this->field104 !="")
		$strb=$strb.$this->field104;
		if($this->field105 !="")
		$strb=$strb.$this->field105;
		if($this->field106 !="")		
		$strb=$strb.$this->field106;
		if($this->field107 !="")
		$strb=$strb.$this->field107;
		if($this->field108 !="")
		$strb=$strb.$this->field108;
		if($this->field109 !="")
		$strb=$strb.$this->field109;
		if($this->field110 !="")
		$strb=$strb.$this->field110;
		if($this->field111 !="")
		$strb=$strb.$this->field111;
		if($this->field112 !="")
		$strb=$strb.$this->field112;
		if($this->field113 !="")
		$strb=$strb.$this->field113;
		if($this->field114 !="")
		$strb=$strb.$this->field114;
		if($this->field115 !="")
		$strb=$strb.$this->field115;
		if($this->field116 !="")
		$strb=$strb.$this->field116;
		if($this->field117 !="")
		$strb=$strb.$this->field117;
		if($this->field118 !="")
		$strb=$strb.$this->field118;
		if($this->field119 !="")
		$strb=$strb.$this->field119;
		if($this->field120 !="")
		$strb=$strb.$this->field120;
		if($this->field121 !="")
		$strb=$strb.$this->field121;
		if($this->field122 !="")
		$strb=$strb.$this->field122;
		if($this->field124 !="")
		$strb=$strb.$this->field124;
		if($this->field125 !="")
		$strb=$strb.$this->field125;
		return $strb;
    }
    
    public function getJsonStr()
    {
        if(is_array($this)){
            return $this;
        }
        $_arr = is_object($this)? get_object_vars($this) :$this;
        foreach ($_arr as $key => $val){
            if($val=="")
                continue;
            $arr[$key] = $val;
        }
        return json_encode($arr);
    }
    
 /**
     * @return the $msgtypeid
     */
    public function getMsgtypeid()
    {
        return $this->msgtypeid;
    }

 /**
     * @return the $tpdu
     */
    public function getTpdu()
    {
        return $this->tpdu;
    }

 /**
     * @return the $msghead
     */
    public function getMsghead()
    {
        return $this->msghead;
    }

 /**
     * @return the $txcode
     */
    public function getTxcode()
    {
        return $this->txcode;
    }

 /**
     * @return the $txdate
     */
    public function getTxdate()
    {
        return $this->txdate;
    }

 /**
     * @return the $txtime
     */
    public function getTxtime()
    {
        return $this->txtime;
    }

 /**
     * @return the $version
     */
    public function getVersion()
    {
        return $this->version;
    }

 /**
     * @return the $field000
     */
    public function getField000()
    {
        return $this->field000;
    }

 /**
     * @return the $field002
     */
    public function getField002()
    {
        return $this->field002;
    }

 /**
     * @return the $field003
     */
    public function getField003()
    {
        return $this->field003;
    }

 /**
     * @return the $field004
     */
    public function getField004()
    {
        return $this->field004;
    }

 /**
     * @return the $field005
     */
    public function getField005()
    {
        return $this->field005;
    }

 /**
     * @return the $field006
     */
    public function getField006()
    {
        return $this->field006;
    }

 /**
     * @return the $field007
     */
    public function getField007()
    {
        return $this->field007;
    }

 /**
     * @return the $field008
     */
    public function getField008()
    {
        return $this->field008;
    }

 /**
     * @return the $field009
     */
    public function getField009()
    {
        return $this->field009;
    }

 /**
     * @return the $field010
     */
    public function getField010()
    {
        return $this->field010;
    }

 /**
     * @return the $field011
     */
    public function getField011()
    {
        return $this->field011;
    }

 /**
     * @return the $field014
     */
    public function getField014()
    {
        return $this->field014;
    }

 /**
     * @return the $field015
     */
    public function getField015()
    {
        return $this->field015;
    }

 /**
     * @return the $field016
     */
    public function getField016()
    {
        return $this->field016;
    }

 /**
     * @return the $field017
     */
    public function getField017()
    {
        return $this->field017;
    }

 /**
     * @return the $field018
     */
    public function getField018()
    {
        return $this->field018;
    }

 /**
     * @return the $field019
     */
    public function getField019()
    {
        return $this->field019;
    }

 /**
     * @return the $field020
     */
    public function getField020()
    {
        return $this->field020;
    }

 /**
     * @return the $field021
     */
    public function getField021()
    {
        return $this->field021;
    }

 /**
     * @return the $field022
     */
    public function getField022()
    {
        return $this->field022;
    }

 /**
     * @return the $field023
     */
    public function getField023()
    {
        return $this->field023;
    }

 /**
     * @return the $field024
     */
    public function getField024()
    {
        return $this->field024;
    }

 /**
     * @return the $field025
     */
    public function getField025()
    {
        return $this->field025;
    }

 /**
     * @return the $field026
     */
    public function getField026()
    {
        return $this->field026;
    }

 /**
     * @return the $field031
     */
    public function getField031()
    {
        return $this->field031;
    }

 /**
     * @return the $field032
     */
    public function getField032()
    {
        return $this->field032;
    }

 /**
     * @return the $field033
     */
    public function getField033()
    {
        return $this->field033;
    }

 /**
     * @return the $field035
     */
    public function getField035()
    {
        return $this->field035;
    }

 /**
     * @return the $field036
     */
    public function getField036()
    {
        return $this->field036;
    }

 /**
     * @return the $field037
     */
    public function getField037()
    {
        return $this->field037;
    }

 /**
     * @return the $field038
     */
    public function getField038()
    {
        return $this->field038;
    }

 /**
     * @return the $field039
     */
    public function getField039()
    {
        return $this->field039;
    }

 /**
     * @return the $field041
     */
    public function getField041()
    {
        return $this->field041;
    }

 /**
     * @return the $field042
     */
    public function getField042()
    {
        return $this->field042;
    }

 /**
     * @return the $field043
     */
    public function getField043()
    {
        return $this->field043;
    }

 /**
     * @return the $field044
     */
    public function getField044()
    {
        return $this->field044;
    }

 /**
     * @return the $field046
     */
    public function getField046()
    {
        return $this->field046;
    }

 /**
     * @return the $field048
     */
    public function getField048()
    {
        return $this->field048;
    }

 /**
     * @return the $field049
     */
    public function getField049()
    {
        return $this->field049;
    }

 /**
     * @return the $field052
     */
    public function getField052()
    {
        return $this->field052;
    }

 /**
     * @return the $field053
     */
    public function getField053()
    {
        return $this->field053;
    }

 /**
     * @return the $field054
     */
    public function getField054()
    {
        return $this->field054;
    }

 /**
     * @return the $field055
     */
    public function getField055()
    {
        return $this->field055;
    }

 /**
     * @return the $field056
     */
    public function getField056()
    {
        return $this->field056;
    }

 /**
     * @return the $field057
     */
    public function getField057()
    {
        return $this->field057;
    }

 /**
     * @return the $field058
     */
    public function getField058()
    {
        return $this->field058;
    }

 /**
     * @return the $field059
     */
    public function getField059()
    {
        return $this->field059;
    }

 /**
     * @return the $field060
     */
    public function getField060()
    {
        return $this->field060;
    }

 /**
     * @return the $field061
     */
    public function getField061()
    {
        return $this->field061;
    }

 /**
     * @return the $field062
     */
    public function getField062()
    {
        return $this->field062;
    }

 /**
     * @return the $field063
     */
    public function getField063()
    {
        return $this->field063;
    }

 /**
     * @return the $field064
     */
    public function getField064()
    {
        return $this->field064;
    }

 /**
     * @return the $field065
     */
    public function getField065()
    {
        return $this->field065;
    }

 /**
     * @return the $field070
     */
    public function getField070()
    {
        return $this->field070;
    }

 /**
     * @return the $field089
     */
    public function getField089()
    {
        return $this->field089;
    }

 /**
     * @return the $field090
     */
    public function getField090()
    {
        return $this->field090;
    }

 /**
     * @return the $field096
     */
    public function getField096()
    {
        return $this->field096;
    }

 /**
     * @return the $field098
     */
    public function getField098()
    {
        return $this->field098;
    }

 /**
     * @return the $field100
     */
    public function getField100()
    {
        return $this->field100;
    }

 /**
     * @return the $field101
     */
    public function getField101()
    {
        return $this->field101;
    }

 /**
     * @return the $field102
     */
    public function getField102()
    {
        return $this->field102;
    }

 /**
     * @return the $field103
     */
    public function getField103()
    {
        return $this->field103;
    }

 /**
     * @return the $field104
     */
    public function getField104()
    {
        return $this->field104;
    }

 /**
     * @return the $field105
     */
    public function getField105()
    {
        return $this->field105;
    }

 /**
     * @return the $field106
     */
    public function getField106()
    {
        return $this->field106;
    }

 /**
     * @return the $field107
     */
    public function getField107()
    {
        return $this->field107;
    }

 /**
     * @return the $field108
     */
    public function getField108()
    {
        return $this->field108;
    }

 /**
     * @return the $field109
     */
    public function getField109()
    {
        return $this->field109;
    }

 /**
     * @return the $field110
     */
    public function getField110()
    {
        return $this->field110;
    }

 /**
     * @return the $field111
     */
    public function getField111()
    {
        return $this->field111;
    }

 /**
     * @return the $field112
     */
    public function getField112()
    {
        return $this->field112;
    }

 /**
     * @return the $field113
     */
    public function getField113()
    {
        return $this->field113;
    }

 /**
     * @return the $field114
     */
    public function getField114()
    {
        return $this->field114;
    }

 /**
     * @return the $field115
     */
    public function getField115()
    {
        return $this->field115;
    }

 /**
     * @return the $field116
     */
    public function getField116()
    {
        return $this->field116;
    }

 /**
     * @return the $field117
     */
    public function getField117()
    {
        return $this->field117;
    }

 /**
     * @return the $field118
     */
    public function getField118()
    {
        return $this->field118;
    }

 /**
     * @return the $field119
     */
    public function getField119()
    {
        return $this->field119;
    }

 /**
     * @return the $field120
     */
    public function getField120()
    {
        return $this->field120;
    }

 /**
     * @return the $field121
     */
    public function getField121()
    {
        return $this->field121;
    }

 /**
     * @return the $field122
     */
    public function getField122()
    {
        return $this->field122;
    }

 /**
     * @return the $field124
     */
    public function getField124()
    {
        return $this->field124;
    }

 /**
     * @return the $field125
     */
    public function getField125()
    {
        return $this->field125;
    }

 /**
     * @return the $field128
     */
    public function getField128()
    {
        return $this->field128;
    }

 /**
     * @param string $msgtypeid
     */
    public function setMsgtypeid($msgtypeid)
    {
        $this->msgtypeid = $msgtypeid;
    }

 /**
     * @param string $tpdu
     */
    public function setTpdu($tpdu)
    {
        $this->tpdu = $tpdu;
    }

 /**
     * @param string $msghead
     */
    public function setMsghead($msghead)
    {
        $this->msghead = $msghead;
    }

 /**
     * @param string $txcode
     */
    public function setTxcode($txcode)
    {
        $this->txcode = $txcode;
    }

 /**
     * @param string $txdate
     */
    public function setTxdate($txdate)
    {
        $this->txdate = $txdate;
    }

 /**
     * @param string $txtime
     */
    public function setTxtime($txtime)
    {
        $this->txtime = $txtime;
    }

 /**
     * @param string $version
     */
    public function setVersion($version)
    {
        $this->version = $version;
    }

 /**
     * @param string $field000
     */
    public function setField000($field000)
    {
        $this->field000 = $field000;
    }

 /**
     * @param string $field002
     */
    public function setField002($field002)
    {
        $this->field002 = $field002;
    }

 /**
     * @param string $field003
     */
    public function setField003($field003)
    {
        $this->field003 = $field003;
    }

 /**
     * @param string $field004
     */
    public function setField004($field004)
    {
        $this->field004 = $field004;
    }

 /**
     * @param string $field005
     */
    public function setField005($field005)
    {
        $this->field005 = $field005;
    }

 /**
     * @param string $field006
     */
    public function setField006($field006)
    {
        $this->field006 = $field006;
    }

 /**
     * @param string $field007
     */
    public function setField007($field007)
    {
        $this->field007 = $field007;
    }

 /**
     * @param string $field008
     */
    public function setField008($field008)
    {
        $this->field008 = $field008;
    }

 /**
     * @param string $field009
     */
    public function setField009($field009)
    {
        $this->field009 = $field009;
    }

 /**
     * @param string $field010
     */
    public function setField010($field010)
    {
        $this->field010 = $field010;
    }

 /**
     * @param string $field011
     */
    public function setField011($field011)
    {
        $this->field011 = $field011;
    }

 /**
     * @param string $field014
     */
    public function setField014($field014)
    {
        $this->field014 = $field014;
    }

 /**
     * @param string $field015
     */
    public function setField015($field015)
    {
        $this->field015 = $field015;
    }

 /**
     * @param string $field016
     */
    public function setField016($field016)
    {
        $this->field016 = $field016;
    }

 /**
     * @param string $field017
     */
    public function setField017($field017)
    {
        $this->field017 = $field017;
    }

 /**
     * @param string $field018
     */
    public function setField018($field018)
    {
        $this->field018 = $field018;
    }

 /**
     * @param string $field019
     */
    public function setField019($field019)
    {
        $this->field019 = $field019;
    }

 /**
     * @param string $field020
     */
    public function setField020($field020)
    {
        $this->field020 = $field020;
    }

 /**
     * @param string $field021
     */
    public function setField021($field021)
    {
        $this->field021 = $field021;
    }

 /**
     * @param string $field022
     */
    public function setField022($field022)
    {
        $this->field022 = $field022;
    }

 /**
     * @param string $field023
     */
    public function setField023($field023)
    {
        $this->field023 = $field023;
    }

 /**
     * @param string $field024
     */
    public function setField024($field024)
    {
        $this->field024 = $field024;
    }

 /**
     * @param string $field025
     */
    public function setField025($field025)
    {
        $this->field025 = $field025;
    }

 /**
     * @param string $field026
     */
    public function setField026($field026)
    {
        $this->field026 = $field026;
    }

 /**
     * @param string $field031
     */
    public function setField031($field031)
    {
        $this->field031 = $field031;
    }

 /**
     * @param string $field032
     */
    public function setField032($field032)
    {
        $this->field032 = $field032;
    }

 /**
     * @param string $field033
     */
    public function setField033($field033)
    {
        $this->field033 = $field033;
    }

 /**
     * @param string $field035
     */
    public function setField035($field035)
    {
        $this->field035 = $field035;
    }

 /**
     * @param string $field036
     */
    public function setField036($field036)
    {
        $this->field036 = $field036;
    }

 /**
     * @param string $field037
     */
    public function setField037($field037)
    {
        $this->field037 = $field037;
    }

 /**
     * @param string $field038
     */
    public function setField038($field038)
    {
        $this->field038 = $field038;
    }

 /**
     * @param string $field039
     */
    public function setField039($field039)
    {
        $this->field039 = $field039;
    }

 /**
     * @param string $field041
     */
    public function setField041($field041)
    {
        $this->field041 = $field041;
    }

 /**
     * @param string $field042
     */
    public function setField042($field042)
    {
        $this->field042 = $field042;
    }

 /**
     * @param string $field043
     */
    public function setField043($field043)
    {
        $this->field043 = $field043;
    }

 /**
     * @param string $field044
     */
    public function setField044($field044)
    {
        $this->field044 = $field044;
    }

 /**
     * @param string $field046
     */
    public function setField046($field046)
    {
        $this->field046 = $field046;
    }

 /**
     * @param string $field048
     */
    public function setField048($field048)
    {
        $this->field048 = $field048;
    }

 /**
     * @param string $field049
     */
    public function setField049($field049)
    {
        $this->field049 = $field049;
    }

 /**
     * @param string $field052
     */
    public function setField052($field052)
    {
        $this->field052 = $field052;
    }

 /**
     * @param string $field053
     */
    public function setField053($field053)
    {
        $this->field053 = $field053;
    }

 /**
     * @param string $field054
     */
    public function setField054($field054)
    {
        $this->field054 = $field054;
    }

 /**
     * @param string $field055
     */
    public function setField055($field055)
    {
        $this->field055 = $field055;
    }

 /**
     * @param string $field056
     */
    public function setField056($field056)
    {
        $this->field056 = $field056;
    }

 /**
     * @param string $field057
     */
    public function setField057($field057)
    {
        $this->field057 = $field057;
    }

 /**
     * @param string $field058
     */
    public function setField058($field058)
    {
        $this->field058 = $field058;
    }

 /**
     * @param string $field059
     */
    public function setField059($field059)
    {
        $this->field059 = $field059;
    }

 /**
     * @param string $field060
     */
    public function setField060($field060)
    {
        $this->field060 = $field060;
    }

 /**
     * @param string $field061
     */
    public function setField061($field061)
    {
        $this->field061 = $field061;
    }

 /**
     * @param string $field062
     */
    public function setField062($field062)
    {
        $this->field062 = $field062;
    }

 /**
     * @param string $field063
     */
    public function setField063($field063)
    {
        $this->field063 = $field063;
    }

 /**
     * @param string $field064
     */
    public function setField064($field064)
    {
        $this->field064 = $field064;
    }

 /**
     * @param string $field065
     */
    public function setField065($field065)
    {
        $this->field065 = $field065;
    }

 /**
     * @param string $field070
     */
    public function setField070($field070)
    {
        $this->field070 = $field070;
    }

 /**
     * @param string $field089
     */
    public function setField089($field089)
    {
        $this->field089 = $field089;
    }

 /**
     * @param string $field090
     */
    public function setField090($field090)
    {
        $this->field090 = $field090;
    }

 /**
     * @param string $field096
     */
    public function setField096($field096)
    {
        $this->field096 = $field096;
    }

 /**
     * @param string $field098
     */
    public function setField098($field098)
    {
        $this->field098 = $field098;
    }

 /**
     * @param string $field100
     */
    public function setField100($field100)
    {
        $this->field100 = $field100;
    }

 /**
     * @param string $field101
     */
    public function setField101($field101)
    {
        $this->field101 = $field101;
    }

 /**
     * @param string $field102
     */
    public function setField102($field102)
    {
        $this->field102 = $field102;
    }

 /**
     * @param string $field103
     */
    public function setField103($field103)
    {
        $this->field103 = $field103;
    }

 /**
     * @param string $field104
     */
    public function setField104($field104)
    {
        $this->field104 = $field104;
    }

 /**
     * @param string $field105
     */
    public function setField105($field105)
    {
        $this->field105 = $field105;
    }

 /**
     * @param string $field106
     */
    public function setField106($field106)
    {
        $this->field106 = $field106;
    }

 /**
     * @param string $field107
     */
    public function setField107($field107)
    {
        $this->field107 = $field107;
    }

 /**
     * @param string $field108
     */
    public function setField108($field108)
    {
        $this->field108 = $field108;
    }

 /**
     * @param string $field109
     */
    public function setField109($field109)
    {
        $this->field109 = $field109;
    }

 /**
     * @param string $field110
     */
    public function setField110($field110)
    {
        $this->field110 = $field110;
    }

 /**
     * @param string $field111
     */
    public function setField111($field111)
    {
        $this->field111 = $field111;
    }

 /**
     * @param string $field112
     */
    public function setField112($field112)
    {
        $this->field112 = $field112;
    }

 /**
     * @param string $field113
     */
    public function setField113($field113)
    {
        $this->field113 = $field113;
    }

 /**
     * @param string $field114
     */
    public function setField114($field114)
    {
        $this->field114 = $field114;
    }

 /**
     * @param string $field115
     */
    public function setField115($field115)
    {
        $this->field115 = $field115;
    }

 /**
     * @param string $field116
     */
    public function setField116($field116)
    {
        $this->field116 = $field116;
    }

 /**
     * @param string $field117
     */
    public function setField117($field117)
    {
        $this->field117 = $field117;
    }

 /**
     * @param string $field118
     */
    public function setField118($field118)
    {
        $this->field118 = $field118;
    }

 /**
     * @param string $field119
     */
    public function setField119($field119)
    {
        $this->field119 = $field119;
    }

 /**
     * @param string $field120
     */
    public function setField120($field120)
    {
        $this->field120 = $field120;
    }

 /**
     * @param string $field121
     */
    public function setField121($field121)
    {
        $this->field121 = $field121;
    }

 /**
     * @param string $field122
     */
    public function setField122($field122)
    {
        $this->field122 = $field122;
    }

 /**
     * @param string $field124
     */
    public function setField124($field124)
    {
        $this->field124 = $field124;
    }

 /**
     * @param string $field125
     */
    public function setField125($field125)
    {
        $this->field125 = $field125;
    }

 /**
     * @param string $field128
     */
    public function setField128($field128)
    {
        $this->field128 = $field128;
    }


}

?>