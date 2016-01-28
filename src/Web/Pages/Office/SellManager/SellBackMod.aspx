<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SellBackMod.aspx.cs" Inherits="Pages_Office_SellManager_SellBackMod" %>

<%@ Register Src="../../../UserControl/Message.ascx" TagName="Message" TagPrefix="uc7" %>
<%@ Register Src="../../../UserControl/CodingRuleControl.ascx" TagName="CodingRuleControl"
    TagPrefix="uc3" %>
<%@ Register Src="../../../UserControl/CodeTypeDrpControl.ascx" TagName="CodeTypeDrpControl"
    TagPrefix="uc2" %>
<%@ Register Src="../../../UserControl/sellModuleSelectCustUC.ascx" TagName="sellModuleSelectCustUC"
    TagPrefix="uc4" %>
<%@ Register Src="../../../UserControl/ProductInfoControl.ascx" TagName="ProductInfoControl"
    TagPrefix="uc5" %>
<%@ Register Src="../../../UserControl/FlowApply.ascx" TagName="FlowApply" TagPrefix="uc9" %>
<%@ Register Src="../../../UserControl/SelectSellSendUC.ascx" TagName="SelectSellSendUC"
    TagPrefix="uc1" %>
<%@ Register Src="../../../UserControl/SelectSellSendDetailUC.ascx" TagName="SelectSellSendDetailUC"
    TagPrefix="uc6" %>
<%@ Register Src="../../../UserControl/SellModuleSelectCurrency.ascx" TagName="SellModuleSelectCurrency"
    TagPrefix="uc8" %>
<%@ Register Src="../../../UserControl/GetGoodsInfoByBarCode.ascx" TagName="GetGoodsInfoByBarCode"
    TagPrefix="uc10" %>
<%@ Register Src="../../../UserControl/Common/StorageSnapshot.ascx" TagName="StorageSnapshot"
    TagPrefix="uc13" %>
<%@ Register Src="../../../UserControl/Common/GetExtAttributeControl.ascx" TagName="GetExtAttributeControl"
    TagPrefix="uc14" %>
<%@ Register Src="../../../UserControl/Common/ProjectSelectControl.ascx" TagName="ProjectSelectControl" TagPrefix="uc15" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>�����˻���</title>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <link rel="stylesheet" type="text/css" href="../../../css/default.css" />
    <link href="../../../css/pagecss.css" type="text/css" rel="Stylesheet" />

    <script src="../../../js/JQuery/jquery_last.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript" src="../../../js/common/PageBar-1.1.1.js"></script>

    <script src="../../../js/JQuery/formValidator.js" type="text/javascript"></script>

    <script src="../../../js/JQuery/formValidatorRegex.js" type="text/javascript"></script>

    <script src="../../../js/common/UploadFile.js" type="text/javascript"></script>

    <script src="../../../js/Calendar/WdatePicker.js" type="text/javascript"></script>

    <script src="../../../js/common/check.js" type="text/javascript"></script>

    <script src="../../../js/common/page.js" type="text/javascript"></script>

    <script src="../../../js/common/Common.js" type="text/javascript"> </script>

    <script src="../../../js/common/UserOrDeptSelect.js" type="text/javascript"></script>

    <script src="../../../js/office/SellManager/SellBackMod.js" type="text/javascript"></script>
    <script src="../../../js/common/UnitGroup.js" type="text/javascript"></script>

</head>
<body onload="formatNumLen()">
    <form id="EquipAddForm" runat="server">
    <div id="popupContent">
    </div>
    <span id="Forms" class="Spantype"></span>
    <uc7:Message ID="Message1" runat="server" />
    <uc10:GetGoodsInfoByBarCode ID="GetGoodsInfoByBarCode1" runat="server" />
    <uc13:StorageSnapshot ID="StorageSnapshot1" runat="server" />
    <uc2:CodeTypeDrpControl ID="PackageUC" runat="server" />
    <asp:DropDownList runat="server" name="ddlReasonType" ID="ddlReasonType">
    </asp:DropDownList>
    <uc4:sellModuleSelectCustUC ID="sellModuleSelectCustUC1" runat="server" />
    <uc5:ProductInfoControl ID="ProductInfoControl1" runat="server" />
    <input type='hidden' id="rowIndex" />
    <asp:HiddenField ID="hiddSeller" runat="server" />
    <uc9:FlowApply ID="FlowApply1" runat="server" />
    <uc1:SelectSellSendUC ID="SelectSellSendUC1" runat="server" />
    <uc6:SelectSellSendDetailUC ID="SelectSellSendDetailUC1" runat="server" />
    <uc8:SellModuleSelectCurrency ID="SellModuleSelectCurrency1" runat="server" />
    <uc8:SellModuleSelectCurrency ID="SellModuleSelectCurrency2" runat="server" />
    <uc15:ProjectSelectControl ID="ProjectSelectControl1" runat="server" /><!--������Ŀ-->
    <input type="hidden" id="HiddenURLParams" runat="server" />
    <input type='hidden' id='txtTRLastIndex' value="0" />
    <input type="hidden" id='hiddBillStatus' value='1' />
    <input type="hidden" id="hiddDeptID" />
    <input type="hidden" id="hiddOrderID" value='0' />
    <input type ="hidden" id="txtIsMoreUnit" runat="server" /><!--�Ƿ����ö൥λ-->
    
    <script type="text/javascript">
    var glb_BillTypeFlag =<%=XBase.Common.ConstUtil.CODING_RULE_SELL %>;
    var glb_BillTypeCode = <%=XBase.Common.ConstUtil.CODING_RULE_SELLBACK_NO %>;
    var glb_BillID = 0;                                //����ID
    var glb_IsComplete = true;                                          //�Ƿ���Ҫ�ᵥ��ȡ���ᵥ(Сд��ĸ)
    var FlowJS_HiddenIdentityID ='hiddOrderID';                      //���������������ID
    var FlowJs_BillNo ='OfferNo';          //��ǰ���ݱ�������
    var FlowJS_BillStatus ='hiddBillStatus';                             //����״̬ID
    
    var precisionLength=<%=SelPoint %>;//С������
    //ת����ʼ��ֵС��λ��
    function formatNumLen()
    {
        var lengthstr="0.";
        var lengthstr2="100.";
        for(var i=0;i<precisionLength;i++)
        {
            lengthstr = lengthstr+"0";
            lengthstr2 = lengthstr2+"0";
        }
        $("#TotalPrice").val(lengthstr);
        $("#Tax").val(lengthstr);
        $("#TotalFee").val(lengthstr);
        $("#DiscountTotal").val(lengthstr);
        $("#RealTotal").val(lengthstr);
        $("#CountTotal").val(lengthstr);
        $("#NotPayTotal").val(lengthstr);
        $("#huikuan").val(lengthstr);
        $("#Discount").val(lengthstr2);
    }
    </script>

    <script src="../../../js/common/Flow.js" type="text/javascript"></script>
    <div>
        <table style="width: 95%;" border="0" cellpadding="0" cellspacing="0" class="maintable"
            id="mainindex">
            <tr>
                <td valign="top">
                    <input type="hidden" id="hiddenEquipCode" value="" />
                    <img src="../../../images/Main/Line.jpg" width="122" height="7" />
                </td>
                <td align="center" valign="top">
                </td>
            </tr>
            <tr>
                <td height="30" colspan="2" valign="top" class="Title">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td height="30" align="center" class="Title">
                                �����˻���
                            </td>
                        </tr>
                    </table>
                    <table width="99%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#999999">
                        <tr>
                            <td height="28" bgcolor="#FFFFFF" >
                            <table width="100%">
                                <tr>
                                    <td height="28" bgcolor="#FFFFFF" style="padding-top: 5px; padding-left: 5px;">
                                       
                                         <img runat="server" visible="false" src="../../../images/Button/Bottom_btn_save.jpg"
                                    alt="����" id="btn_save" style="cursor: hand;" onclick="InsertSellOfferData();" />
                                <img runat="server" visible="false" alt="����" src="../../../Images/Button/UnClick_bc.jpg"
                                    id="imgUnSave" style="display: none;" />
                                <span runat="server" visible="false" id="GlbFlowButtonSpan"></span>
                                <img src="../../../Images/Button/Bottom_btn_back.jpg" alt="����" id="ibtnBack" style="cursor: hand"
                                    onclick="fnBack();" />
                                    </td>
                                    <td align="right" bgcolor="#FFFFFF" style="padding-top: 5px; width: 70px;">
                                        <img id="btnPrint" alt="��ӡ" src="../../../images/Button/Main_btn_print.jpg" style="cursor: pointer"
                                            title="��ӡ"  onclick="fnPrintOrder()"  />
                                    </td>
                                </tr>
                            </table>
                               <!-- �������ã��Ƿ��������� -->
                                <input type="hidden" id="hidBarCode" runat="server" value="" />
                            </td>
                           
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2" valign="top">
                    <table width="99%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td height="6">
                            </td>
                        </tr>
                    </table>
                    <table width="99%" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#999999">
                        <tr>
                            <td height="20" bgcolor="#F4F0ED" class="Blue">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3">
                                    <tr>
                                        <td>
                                            ������Ϣ
                                        </td>
                                        <td align="right">
                                            <div id='searchClick'>
                                                <img src="../../../images/Main/Close.jpg" style="cursor: pointer" onclick="oprItem('Tb_01','searchClick')" /></div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <table width="99%" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#999999"
                        id="Tb_01">
                        <tr>
                            <td align="right" bgcolor="#E6E6E6" style="width: 10%">
                                ���ݱ��<span class="redbold">*</span>
                            </td>
                            <td bgcolor="#FFFFFF" style="width: 23%">
                                <input type="text" class="tdinput" disabled="disabled" style="width: 95%;" id="OfferNo" />
                            </td>
                            <td align="right" bgcolor="#E6E6E6" style="width: 10%">
                                ����
                            </td>
                            <td bgcolor="#FFFFFF" style="width: 23%">
                                <input id="BackCargoTheme" specialworkcheck="����" type="text" style="width: 95%;"
                                    class="tdinput" maxlength="50" />
                            </td>
                            <td align="right" bgcolor="#E6E6E6" style="width: 10%">
                                Դ������<span class="redbold">*</span>
                            </td>
                            <td bgcolor="#FFFFFF">
                                <select  style="width: 120px;margin-top:2px;margin-left:2px;" id="FromType" onchange="fnFromTypeChange(this)">
                                    <option value="0" selected="selected">����Դ</option>
                                    <option value="1">���۷�����</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                Դ�����
                            </td>
                            <td height="20" bgcolor="#FFFFFF">
                                <input id="FromBillID" onclick="fnSelectOfferInfo()" class="tdinput" type="text"
                                    readonly="true" style="width: 95%;" />
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                �ͻ�����<span class="redbold">*</span>
                            </td>
                            <td height="20" bgcolor="#FFFFFF">
                                <input id="CustID" class="tdinput" type="text" readonly="readonly" style="width: 95%;"
                                    onclick="fnSelectCustInfo()" />
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                �ͻ��绰
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF">
                                <input id="CustTel" class="tdinput" type="text" style="width: 95%;" maxlength="50" />
                            </td>
                        </tr>
                        <tr>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                ҵ������<span class="redbold">*</span>
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF">
                                <select  style="width: 120px;margin-top:2px;margin-left:2px;" id="BusiType">
                                    <option value="1">��ͨ����</option>
                                    <option value="2">ί�д���</option>
                                    <option value="3">ֱ��</option>
                                    <option value="4">����</option>
                                    <option value="5">���۵���</option>
                                </select>
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                ���㷽ʽ
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF">
                                <uc2:CodeTypeDrpControl ID="PayTypeUC" runat="server" />
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                ֧����ʽ
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF">
                                <uc2:CodeTypeDrpControl ID="MoneyTypeUC" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                ���ͷ�ʽ
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF">
                                <uc2:CodeTypeDrpControl ID="CarryType" runat="server" />
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                ����<span class="redbold">*</span>
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF">
                                <input id="CurrencyType" class="tdinput" type="text" onclick="fnSelectCurrency()"
                                    readonly="readonly" style="width: 95%;" maxlength="100" />
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                ����
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF">
                                <input id="Rate" style="width: 95%;" class="tdinput" type="text" disabled="disabled"
                                    value="0.0000" />
                            </td>
                        </tr>
                        <tr>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                ҵ��Ա<span class="redbold">*</span>
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF">
                                <asp:TextBox ID="UserSeller" Width="95%" ReadOnly="true" class="tdinput" runat="server"
                                    onclick="fnSelectSeller()"></asp:TextBox>
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                ����<span class="redbold">*</span>
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF">
                                <input id="DeptId" readonly="readonly" style="width: 95%;" class="tdinput" type="text"
                                    onclick="fnSelectDept()" />
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                ������ַ
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF">
                                <input id="SendAddress" specialworkcheck="������ַ" class="tdinput" type="text" style="width: 95%;"
                                    maxlength="100" />
                            </td>
                        </tr>
                        <tr>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                �ջ���ַ
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF">
                                <input id="ReceiveAddress" specialworkcheck="�ջ���ַ" class="tdinput" type="text" style="width: 95%;"
                                    maxlength="100" />
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                �˻�����<span class="redbold">*</span>
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF">
                                <asp:TextBox ID="BackDate" ReadOnly="true" Width="95%" class="tdinput" runat="server"
                                    onclick="WdatePicker({dateFmt:'yyyy-MM-dd',el:$dp.$('SendDate')})"></asp:TextBox>
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                �Ƿ���ֵ˰<span class="redbold">*</span>
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF">
                                <input id="isAddTax" checked="checked" name="AddTax" onclick="fnAddTax()" type="radio"
                                    value="1" />��
                                <input id="NotAddTax" name="AddTax" onclick="fnAddTax()" type="radio" value="0" />��
                            </td>
                        </tr>
                        <tr>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                �Ƿ�����
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF">
                                <input id="isRef" class="tdinput" disabled="disabled" type="text" value="δ������" />
                            </td>
                            <td align="right" bgcolor="#E6E6E6">
                                ������Ŀ
                            </td>
                            <td align="left" bgcolor="#FFFFFF">
                                <input id="ProjectID" class="tdinput" type="text" style="width:60%" readonly="readonly" onclick="ShowProjectInfo('ProjectID','hiddProjectID');"/>
                                <%--<a href="#" onclick="fnClearProject();">���ѡ��</a>--%>
                                <input id="hiddProjectID" type="hidden" runat="server" />
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF">
                            </td>
                        </tr>
                    </table>
                    <!-- ��չ����-->
                    <uc14:GetExtAttributeControl ID="GetExtAttributeControl1" runat="server" />
                    <br />
                    <table width="99%" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#999999">
                        <tr>
                            <td height="20" bgcolor="#F4F0ED" class="Blue">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3">
                                    <tr>
                                        <td>
                                            �ϼ���Ϣ
                                        </td>
                                        <td align="right">
                                            <div id='searchClick1'>
                                                <img src="../../../images/Main/Close.jpg" style="cursor: pointer" onclick="oprItem('Tb_02','searchClick1')" /></div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <table width="99%" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#999999"
                        id="Tb_02">
                        <tr>
                            <td height="20" align="right" bgcolor="#E6E6E6" style="width: 11%">
                                ���ϼ�
                            </td>
                            <td height="20" bgcolor="#FFFFFF" style="width: 22%">
                                <input id="TotalPrice" disabled="disabled" style="width: 95%;" class="tdinput" type="text"
                                    size="15" />
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6" style="width: 11%">
                                ˰��ϼ�
                            </td>
                            <td height="20" bgcolor="#FFFFFF" style="width: 22%">
                                <input id="Tax" disabled="disabled" style="width: 95%;" class="tdinput" type="text"
                                    size="15" />
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6" style="width: 11%">
                                ��˰���ϼ�
                            </td>
                            <td height="20" bgcolor="#FFFFFF">
                                <input id="TotalFee" disabled="disabled" style="width: 95%;" class="tdinput" type="text"
                                    size="15" />
                            </td>
                        </tr>
                        <tr>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                �����ۿ�(%)<span class="redbold">*</span>
                            </td>
                            <td height="20" bgcolor="#FFFFFF">
                                <input id="Discount" onchange="Number_round(this,<%=SelPoint %>)" value="100.00" onblur="fnTotalInfo()"
                                    style="width: 120px;" class="tdinput" type="text" size="15" />
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                �ۿ۽��
                            </td>
                            <td height="20" bgcolor="#FFFFFF">
                                <input id="DiscountTotal" disabled="disabled" style="width: 95%;" class="tdinput"
                                    type="text" size="15" />
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                �ۺ�˰���
                            </td>
                            <td height="20" bgcolor="#FFFFFF">
                                <input id="RealTotal" disabled="disabled" style="width: 95%;" class="tdinput" type="text"
                                    size="15" />
                            </td>
                        </tr>
                        <tr>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                �˻������ϼ�
                            </td>
                            <td height="20" bgcolor="#FFFFFF">
                                <input id="CountTotal" disabled="disabled" style="width: 95%;" class="tdinput" type="text"
                                    size="15" />
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                ��Ӧ�ջ���
                            </td>
                            <td height="20" bgcolor="#FFFFFF">
                                <input id="NotPayTotal" style="width: 95%;" onblur="fnTotalInfo()" class="tdinput"
                                    type="text" onchange="Number_round(this,<%=SelPoint %>)" maxlength="8" />
                            </td>
                            <td align="right" bgcolor="#E6E6E6">
                            </td>
                            <td align="left" bgcolor="#FFFFFF">
                            </td>
                        </tr>
                    </table>
                    <br />
                    <table width="99%" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#999999">
                        <tr>
                            <td height="20" bgcolor="#F4F0ED" class="Blue">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3">
                                    <tr>
                                        <td>
                                            ��ص���״̬
                                        </td>
                                        <td align="right">
                                            <div id='Div2'>
                                                <img src="../../../images/Main/Close.jpg" style="cursor: pointer" onclick="oprItem('Tb_05','Div2')" /></div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <table width="99%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#999999"
                        id="Tb_05">
                        <tr>
                            <td height="28" align="right" bgcolor="#E6E6E6" style="width: 11%">
                                �������
                            </td>
                            <td height="28" align="left" bgcolor="#FFFFFF" style="width: 22%">
                                <input id="isOpenbillText" readonly="readonly" style="width: 95%;" class="tdinput"
                                    type="text" size="15" />
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6" style="width: 11%">
                                ����״̬
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF" style="width: 22%">
                                <input id="IsAccText" readonly="readonly" style="width: 95%;" class="tdinput" type="text"
                                    size="15" />
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6" style="width: 11%">
                                �ѽ�����
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF">
                                <input id="huikuan" disabled="disabled" style="width: 95%;" class="tdinput" value="0.00"
                                    type="text" />
                            </td>
                        </tr>
                        <tr>
                            <td height="28" align="right" bgcolor="#E6E6E6" style="width: 11%">
                                ������
                            </td>
                            <td height="28" align="left" bgcolor="#FFFFFF" style="width: 22%">
                                <input id="isSendText" readonly="readonly" style="width: 95%;" class="tdinput" type="text"
                                    size="15" />
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6" style="width: 11%">
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF" style="width: 22%">
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6" style="width: 11%">
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF">
                            </td>
                        </tr>
                    </table>
                    <br />
                    <table width="99%" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#999999">
                        <tr>
                            <td height="20" bgcolor="#F4F0ED" class="Blue">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3">
                                    <tr>
                                        <td>
                                            ��ע��Ϣ
                                        </td>
                                        <td align="right">
                                            <div id='searchClick2'>
                                                <img src="../../../images/Main/Close.jpg" style="cursor: pointer" onclick="oprItem('Tb_03','searchClick2')" /></div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <table width="99%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#999999"
                        id="Tb_03">
                        <tr>
                            <td height="20" align="right" bgcolor="#E6E6E6" style="width: 11%">
                                ����״̬
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF" style="width: 22%">
                                <label id="BillStatus">
                                    �Ƶ�</label>
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6" style="width: 11%">
                                �Ƶ���
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF" style="width: 22%">
                                <asp:TextBox ID="Creator" Width="120px" runat="server" CssClass="tdinput" Enabled="false"></asp:TextBox>
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6" style="width: 11%">
                                �Ƶ�����
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF" style="width: 23%">
                                <asp:TextBox ID="CreateDate" runat="server" Width="120px" CssClass="tdinput" Enabled="false"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                ȷ����
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF">
                                <asp:TextBox ID="Confirmor" runat="server" Width="120px" CssClass="tdinput" Enabled="false"></asp:TextBox>
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                ȷ������
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF">
                                <asp:TextBox ID="ConfirmDate" runat="server" Width="120px" CssClass="tdinput" Enabled="false"></asp:TextBox>
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                �ᵥ��
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF">
                                <asp:TextBox ID="Closer" runat="server" Width="120px" Enabled="false" CssClass="tdinput"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                �ᵥ����
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF">
                                <asp:TextBox ID="CloseDate" runat="server" Width="120px" CssClass="tdinput" Enabled="false"></asp:TextBox>
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                ��������
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF">
                                <asp:TextBox ID="ModifiedUserID" runat="server" Width="120px" CssClass="tdinput"
                                    Enabled="false"></asp:TextBox>
                            </td>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                ����������
                            </td>
                            <td height="20" align="left" bgcolor="#FFFFFF">
                                <asp:TextBox ID="ModifiedDate" runat="server" Width="120px" CssClass="tdinput" Enabled="false"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td height="20" align="right" bgcolor="#E6E6E6">
                                ��ע
                            </td>
                            <td height="20" colspan="5" align="left" bgcolor="#FFFFFF">
                                <input id="Remark" specialworkcheck="��ע" class="tdinput" style="width: 98%" type="text"
                                    maxlength="100" />
                            </td>
                        </tr>
                    </table>
                    <br />
                    <table width="99%" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#999999">
                        <tr>
                            <td valign="top" bgcolor="#F4F0ED">
                                <img src="../../../images/Main/Line.jpg" width="122" height="7" />
                            </td>
                            <td align="right" valign="top" bgcolor="#F4F0ED">
                                <img src="../../../images/Main/LineR.jpg" width="122" height="7" />
                            </td>
                        </tr>
                        <tr>
                            <td height="20" bgcolor="#F4F0ED" class="Blue" colspan="2">
                                <table width="100%" border="0" cellspacing="0" cellpadding="3">
                                    <tr>
                                        <td valign="top">
                                            <span class="Blue">�˻�����ϸ</span>
                                        </td>
                                        <td align="right" valign="top">
                                            <div id='searchClick3'>
                                                <img src="../../../images/Main/Close.jpg" style="cursor: pointer" onclick="oprItem('Table2','searchClick3')" /></div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#999999"
                        id="Table2">
                        <tr>
                            <td>
                                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#999999">
                                    <tr>
                                        <td height="28" bgcolor="#FFFFFF" colspan="11" style="padding-top: 5px; padding-left: 5px;">
                                            <img runat="server" visible="false" alt="����" src="../../../images/Button/Show_add.jpg"
                                                id="imgAdd" style="cursor: hand" onclick="AddSignRows();" />
                                            <img runat="server" visible="false" alt="ɾ��" src="../../../images/Button/Show_del.jpg"
                                                id="imgDel" style="cursor: hand" onclick="fnDelOneRow()" />
                                            <img runat="server" visible="false" alt="����" src="../../../Images/Button/UnClick_tj.jpg"
                                                style="display: none;" id="imgUnAdd" />
                                            <img runat="server" visible="false" alt="ɾ��" src="../../../Images/Button/UnClick_del.jpg"
                                                style="display: none;" id="imgUnDel" />
                                            <img runat="server" visible="false" src="../../../Images/Button/Bottom_btn_From.jpg"
                                                id="btnFromBill" alt="ѡ����ϸ" style="cursor: hand;" onclick="fnSelectOrderList()" />
                                            <img runat="server" visible="false" alt="ѡ����ϸ" src="../../../Images/Button/Unclick_From.jpg"
                                                id="btnUnFromBill" style="display: none;" />
                                            <img id="btnSubSnapshot" src="../../../images/Button/btn_kckz.jpg" style="cursor: hand"
                                                onclick="ShowSnapshot();" alt="������" />
                                            <img alt="����ɨ��" src="../../../Images/Button/btn_tmsm.jpg" id="GetGoods"  style="cursor: pointer" onclick="fnGetProInfoByBarCode()" runat="server"   visible="false"  />
                                        <img alt="����ɨ��" src="../../../Images/Button/btn_tmsmu.jpg"  id="UnGetGoods"  style=" display:none" runat="server"  visible="false" />
                                        </td>
                                    </tr>
                                </table>
                                <div id="divDetail" style="width: 100%; background-color: #FFFFFF; overflow: scroll;">
                                    <div style="border: none; width: 220%">
                                        <table width="100%" border="0" id="dg_Log" style="behavior: url(../../../draggrid.htc);
                                            height: auto;" align="center" cellpadding="0" cellspacing="1" bgcolor="#999999">
                                            <tr>
                                                <td align="center" bgcolor="#E6E6E6" class="ListTitle" style="width: 3%">
                                                    ѡ��<input type="checkbox" visible="false" id="checkall" onclick="fnSelectAll()" value="checkbox" />
                                                </td>
                                                <td align="center" bgcolor="#E6E6E6" style="width: 6%" class="ListTitle">
                                                    ��Ʒ���<span class="redbold">*</span>
                                                </td>
                                                <td align="center" bgcolor="#E6E6E6" style="width: 6%" class="ListTitle">
                                                    ��Ʒ����
                                                </td>
                                                <td align="center" bgcolor="#E6E6E6" style="width: 3%" class="ListTitle">
                                                    ���
                                                </td>
                                                <td align="center" bgcolor="#E6E6E6" style="width: 3%" class="ListTitle">
                                                    ��ɫ
                                                </td>
                                                <td align="center" id="BaseUnitD" runat="server" bgcolor="#E6E6E6" style="width: 5%" class="ListTitle">
                                                    ������λ
                                                </td>
                                                <td align="center" id="BaseCountD" runat="server" bgcolor="#E6E6E6" style="width: 5%" class="ListTitle">
                                                    ��������
                                                </td>
                                                <td align="center" bgcolor="#E6E6E6" style="width: 3%" class="ListTitle">
                                                    ��λ
                                                </td>
                                                <td align="center" bgcolor="#E6E6E6" style="width: 4%" class="ListTitle">
                                                    ��������
                                                </td>
                                                <td align="center" bgcolor="#E6E6E6" style="width: 4%" class="ListTitle">
                                                    ���˻�����
                                                </td>
                                                <td align="center" bgcolor="#E6E6E6" style="width: 4%" class="ListTitle">
                                                    �˻�����<span class="redbold">*</span>
                                                </td>
                                               
                                                <td align="center" bgcolor="#E6E6E6" style="width: 4%" class="ListTitle">
                                                    ��װҪ��
                                                </td>
                                                <td align="center" bgcolor="#E6E6E6" style="width: 4%" class="ListTitle">
                                                    ����<span class="redbold">*</span>
                                                </td>
                                                <td align="center" bgcolor="#E6E6E6" style="width: 4%" class="ListTitle">
                                                    ��˰��<span class="redbold">*</span>
                                                </td>
                                                <td align="center" bgcolor="#E6E6E6" style="width: 4%" class="ListTitle">
                                                    �ۿ�(%)<span class="redbold">*</span>
                                                </td>
                                                <td align="center" bgcolor="#E6E6E6" style="width: 4%" class="ListTitle">
                                                    ˰��(%)<span class="redbold">*</span>
                                                </td>
                                                <td align="center" bgcolor="#E6E6E6" style="width: 5%" class="ListTitle">
                                                    ��˰���
                                                </td>
                                                <td align="center" bgcolor="#E6E6E6" style="width: 5%" class="ListTitle">
                                                    ���
                                                </td>
                                                <td align="center" bgcolor="#E6E6E6" style="width: 4%" class="ListTitle">
                                                    ˰��
                                                </td>
                                                <td align="center" bgcolor="#E6E6E6" style="width: 5%" class="ListTitle">
                                                    �˻�ԭ��
                                                </td>
                                                <td align="center" bgcolor="#E6E6E6" class="ListTitle">
                                                    ��ע
                                                </td>
                                                <td align="center" bgcolor="#E6E6E6" style="width: 4%" class="ListTitle">
                                                    Դ������
                                                </td>
                                                <td align="center" bgcolor="#E6E6E6" style="width: 4%" class="ListTitle">
                                                    Դ�����
                                                </td>
                                                <td align="center" bgcolor="#E6E6E6" style="width: 3%" class="ListTitle">
                                                    Դ���к�
                                                </td>
                                                 <td align="center" bgcolor="#E6E6E6" style="width: 4%" class="ListTitle">
                                                    ���������
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div style="height: 20px; width: 200%">
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>

    </form>

</body>
</html>