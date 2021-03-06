﻿using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using CrystalDecisions.Shared;
using CrystalDecisions.CrystalReports.Engine;
using XBase.Model.Office.StorageManager;
using XBase.Business.Office.StorageManager;
using XBase.Common;
using XBase.Model.Common;

public partial class Pages_PrinttingModel_StorageManager_StorageTransferPrint :BasePage
{
    #region MRP ID
    public int intMrpID
    {
        get
        {
            int tempID = 0;
            int.TryParse(Request["ID"], out tempID);
            return tempID;
        }
    }
    public string intMrpNo
    {
        get
        {
            string tempNo = Request["No"].ToString();
            return tempNo;
        }
    }
    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        hidBillTypeFlag.Value = ConstUtil.BILL_TYPEFLAG_STORAGE;
        hidPrintTypeFlag.Value = ConstUtil.PRINTBILL_TYPEFLAG_TRANSFER.ToString();

        if (!IsPostBack)
        {
            LoadPrintInfo();
        }
    }

    #region 加载打印信息
    protected void LoadPrintInfo()
    {
        PrintParameterSettingModel model = new PrintParameterSettingModel();
        model.CompanyCD = ((UserInfoUtil)SessionUtil.Session["UserInfo"]).CompanyCD;
        model.BillTypeFlag = int.Parse(ConstUtil.BILL_TYPEFLAG_STORAGE);
        model.PrintTypeFlag = ConstUtil.PRINTBILL_TYPEFLAG_TRANSFER;

        StorageInitailModel OutSellM_ = new StorageInitailModel();
        OutSellM_.CompanyCD = ((UserInfoUtil)SessionUtil.Session["UserInfo"]).CompanyCD;
        OutSellM_.ID = this.intMrpID.ToString();

        /*此处需注意在模板设置表里的字段和取基本信息的字段是否一致*/
        string[,] aBase = { 
                                { "{ExtField1}", "ExtField1"},
                                { "{ExtField2}", "ExtField2"},
                                { "{ExtField3}", "ExtField3"},
                                { "{ExtField4}", "ExtField4"},
                                { "{ExtField5}", "ExtField5"},
                                { "{ExtField6}", "ExtField6"},
                                { "{ExtField7}", "ExtField7"},
                                { "{ExtField8}", "ExtField8"},
                                { "{ExtField9}", "ExtField9"},
                                { "{ExtField10}", "ExtField10"},
                                { "调拨单编号", "TransferNo"}, 
                                { "调拨单主题", "Title"}, 
                                { "调拨申请人", "ApplyUserIDName" },
                                { "要货部门", "ApplyDeptIDName" },
                                { "调入仓库", "InStorageName"},
                                { "要求到货日期", "RequireInDate"},
                                { "调拨原因 ", "Reason"},
                                { "调货部门 ", "OutDeptIDName"},
                                { "调出仓库 ", "OutStorageName"},
                             
                                { "业务状态", "BusiStatusText"},
                                { "摘要", "Summary"},
                                { "调拨数量合计 ", "TransferCount"},

                                { "调拨金额合计 ", "TransferPrice"},
                                { "调拨费用 ", "TransferFeeSum"},


                                { "制单人", "CreatorName"},

                                { "制单日期", "CreateDate"},
                                { "单据状态", "BillStatusText"},
                                { "确认人", "ConfirmorName"},
                                { "确认日期", "ConfirmDate"},
                                { "结单人", "CloserName"},
                                { "结单日期", "CloseDate"},
                                { "最后更新人", "ModifiedUserID"},
                                { "最后更新日期", "ModifiedDate"},
                                { "备注", "Remark"},

                          };

        string[,] aDetail =null;
        if(!UserInfo.IsMoreUnit)
      aDetail= new string[,] { 
                                { "序号", "SortNo"}, 
                                { "物品编号", "ProdNo"}, 
                                { "物品名称", "ProductName" },
                                {"批次","BatchNo"},
                                { "规格", "Specification" },
                                { "单位", "UnitName"},
                                { "调拨单价", "TranPrice"},
                                { "调拨数量 ", "TranCount"},
                                { "调拨金额 ", "TranPriceTotal"},
                                { "已出库数量 ", "OutCount"},
                                { "已入库数量 ", "InCount"},
                                { "备注 ", "Remark"},

                           };
        else
            aDetail = new string[,] { 
                                { "序号", "SortNo"}, 
                                { "物品编号", "ProdNo"}, 
                                { "物品名称", "ProductName" },
                                 {"批次","BatchNo"},
                                { "规格", "Specification" },
                                { "基本单位", "UnitName"},
                                {"基本数量","TranCount"},
                                { "单位", "UsedUnitName"},
                                { "调拨单价", "TranPrice"},
                                { "调拨数量 ", "UsedUnitCount"},
                                { "调拨金额 ", "TranPriceTotal"},
                                { "已出库数量 ", "OutCount"},
                                { "已入库数量 ", "InCount"},
                                { "备注 ", "Remark"},

                           };



        #region 1.扩展属性
        int countExt = 0;
        DataTable dtExtTable = XBase.Business.Office.SupplyChain.TableExtFieldsBus.GetAllList(((UserInfoUtil)SessionUtil.Session["UserInfo"]).CompanyCD, "", "officedba.StorageTransfer");
        if (dtExtTable.Rows.Count > 0)
        {
            for (int i = 0; i < dtExtTable.Rows.Count; i++)
            {
                for (int x = 0; x < (aBase.Length / 2) - 15; x++)
                {
                    if (x == i)
                    {
                        aBase[x, 0] = dtExtTable.Rows[i]["EFDesc"].ToString();
                        countExt++;
                    }
                }
            }
        }
        #endregion
        string No = Request.QueryString["No"].ToString();
        DataTable dbPrint = XBase.Business.Common.PrintParameterSettingBus.GetPrintParameterSettingInfo(model);

        XBase.Model.Office.StorageManager.StorageTransfer st = new XBase.Model.Office.StorageManager.StorageTransfer();
        st.ID = intMrpID;
        XBase.Model.Office.StorageManager.StorageTransferDetail std = new XBase.Model.Office.StorageManager.StorageTransferDetail();
        std.CompanyCD = ((UserInfoUtil)SessionUtil.Session["UserInfo"]).CompanyCD;
        std.TransferNo = No;
        /*读取数据*/
        DataTable dtMRP =  XBase.Business.Office.StorageManager.StorageTransferBus.GetStorageTransferInfoPrint(st);
        DataTable dtDetail = XBase.Business.Office.StorageManager.StorageTransferBus.GetStorageTransferDetailInfo(std);
        string strBaseFields = "";
        string strDetailFields = "";


        if (dbPrint.Rows.Count > 0)
        {
            #region 设置过打印模板设置时 直接取出表里设置的值
            isSeted.Value = "1";
            strBaseFields = dbPrint.Rows[0]["BaseFields"].ToString();
            strDetailFields = dbPrint.Rows[0]["DetailFields"].ToString();
            #endregion
        }
        else
        {
            #region 未设置过打印模板设置 默认显示所有的
            isSeted.Value = "0";

            /*未设置过打印模板设置时，默认显示的字段  基本信息字段*/
            for (int m = 10; m < aBase.Length / 2; m++)
            {
                strBaseFields = strBaseFields + aBase[m, 1] + "|";
            }
            /*未设置过打印模板设置时，默认显示的字段 基本信息字段+扩展信息字段*/
            if (countExt > 0)
            {
                for (int i = 0; i < countExt; i++)
                {
                    strBaseFields = strBaseFields + "ExtField" + (i + 1) + "|";
                }
            }
            /*未设置过打印模板设置时，默认显示的字段 明细信息字段*/
            for (int n = 0; n < aDetail.Length / 2; n++)
            {
                strDetailFields = strDetailFields + aDetail[n, 1] + "|";
            }
            #endregion
        }

        #region 2.主表信息
        if (!string.IsNullOrEmpty(strBaseFields))
        {
            tableBase.InnerHtml = WritePrintPageTable("库存调拨单", strBaseFields.TrimEnd('|'), strDetailFields.TrimEnd('|'), aBase, aDetail, dtMRP, dtDetail, true);
        }
        #endregion

        #region 3.明细信息
        if (!string.IsNullOrEmpty(strDetailFields))
        {
            tableDetail.InnerHtml = WritePrintPageTable("库存调拨单", strBaseFields.TrimEnd('|'), strDetailFields.TrimEnd('|'), aBase, aDetail, dtMRP, dtDetail, false);
        }
        #endregion

    }
    #endregion

    #region 导出
    protected void btnImport_Click(object sender, EventArgs e)
    {
        System.IO.StringWriter tw = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);
        Response.Clear();
        Response.Charset = "gb2312";
        Response.ContentType = "application/vnd.ms-excel";
        Response.ContentEncoding = System.Text.Encoding.GetEncoding("gb2312");
        Response.AppendHeader("Content-Disposition", "attachment;filename=" + System.Web.HttpUtility.UrlEncode("库存调拨单") + ".xls");
        Response.Write("<html><head><META http-equiv=\"Content-Type\" content=\"text/html; charset=gb2312\"></head><body>");
        Response.Write(hiddExcel.Value);
        Response.Write(tw.ToString());
        Response.Write("</body></html>");
        Response.End();
        hw.Close();
        hw.Flush();
        tw.Close();
        tw.Flush();
    }
    #endregion
}
