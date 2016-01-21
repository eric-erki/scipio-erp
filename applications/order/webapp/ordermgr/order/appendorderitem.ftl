<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

<@script>
  function quicklookup(element) {
    window.location='<@ofbizUrl>LookupBulkAddSupplierProductsInApprovedOrder</@ofbizUrl>?orderId='+element.value;
  }
</@script>

<#if orderHeader?has_content>
  <@section title="${uiLabelMap.OrderAddToOrder}">
    <@row>
      <@cell columns=6>
        <form method="post" action="<@ofbizUrl>appendItemToOrder</@ofbizUrl>" name="appendItemForm">
            <input type="hidden" size="25" name="orderId" value="${orderId!}"/>
            <#if !catalogCol?has_content>
                <input type="hidden" name="prodCatalogId" value=""/>
            </#if>
            <#if catalogCol?has_content && catalogCol?size == 1>
                <input type="hidden" name="prodCatalogId" value="${catalogCol.first}"/>
            </#if>
            <#if shipGroups?size == 1>
                <input type="hidden" name="shipGroupSeqId" value="${shipGroups.first.shipGroupSeqId}"/>
            </#if>
             
            <@table type="fields" cellspacing="0"> <#-- orig: class="basic-table" -->
              <#if catalogCol?has_content && (catalogCol?size > 1)>
                <@tr>
                  <@td scope="row" class="${styles.grid_large!}3">${uiLabelMap.ProductChooseCatalog}</@td>
                  <@td><select name="prodCatalogId">
                    <#list catalogCol as catalogId>
                      <#assign thisCatalogName = Static["org.ofbiz.product.catalog.CatalogWorker"].getCatalogName(request, catalogId)>
                      <option value="${catalogId}">${thisCatalogName}</option>
                    </#list>
                  </select>
                  </@td>
                </@tr>
              </#if>
                <@tr>
                  <@td scope="row" class="${styles.grid_large!}3">${uiLabelMap.ProductProductId}</@td>
                  <@td>
                      <#-- FIXME Problem here: the input field is shared -->
                      <@htmlTemplate.lookupField formName="appendItemForm" name="productId" id="productId" fieldFormName="LookupProduct"/>
                      <#if "PURCHASE_ORDER" == orderHeader.orderTypeId>
                          <a href="javascript:quicklookup(document.appendItemForm.orderId)" class="${styles.link_nav!} ${styles.action_find!}">${uiLabelMap.OrderQuickLookup}</a>
                      </#if>
                  </@td>
                </@tr>
                <@tr>
                  <@td scope="row" class="${styles.grid_large!}3">${uiLabelMap.OrderPrice}</@td>
                  <@td>
                    <input type="text" size="6" name="basePrice" value="${requestParameters.price!}"/>
                    <input type="checkbox" name="overridePrice" value="Y"/>&nbsp;${uiLabelMap.OrderOverridePrice}
                  </@td>
                </@tr>
                <@tr>
                  <@td scope="row" class="${styles.grid_large!}3">${uiLabelMap.OrderQuantity}</@td>
                  <@td><input type="text" size="6" name="quantity" value="${requestParameters.quantity?default("1")}"/></@td>
                </@tr>
              <#if (shipGroups?size > 1)>
                <@tr>
                  <@td scope="row" class="${styles.grid_large!}3">${uiLabelMap.OrderShipGroup}</@td>
                  <@td><select name="shipGroupSeqId">
                      <#list shipGroups as shipGroup>
                         <option value="${shipGroup.shipGroupSeqId}">${shipGroup.shipGroupSeqId}</option>
                      </#list>
                      </select>
                  </@td>
                </@tr>
              </#if>
                <@tr>
                  <@td scope="row" class="${styles.grid_large!}3">${uiLabelMap.OrderDesiredDeliveryDate}</@td>
                  <@td>
                        <@htmlTemplate.renderDateTimeField name="itemDesiredDeliveryDate" event="" action="" value="" className=""  title="Format: yyyy-MM-dd HH:mm:ss.SSS" size="25" maxlength="30" id="itemDesiredDeliveryDate1" dateType="date" shortDateInput=false timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName=""/>
                  </@td>
                </@tr>
                <@tr>
                  <@td scope="row" class="${styles.grid_large!}3">${uiLabelMap.OrderReturnReason}</@td>
                  <@td>
                    <select name="reasonEnumId">
                        <option value="">&nbsp;</option>
                        <#list orderItemChangeReasons as reason>
                        <option value="${reason.enumId}">${reason.get("description",locale)?default(reason.enumId)}</option>
                        </#list>
                    </select>
                  </@td>
                </@tr>
                <#if orderHeader.orderTypeId == "PURCHASE_ORDER" && purchaseOrderItemTypeList?has_content>
                <@tr>
                  <@td scope="row" class="${styles.grid_large!}3">${uiLabelMap.OrderOrderItemType}</@td>
                  <@td>
                    <select name="orderItemTypeId">
                      <option value="">&nbsp;</option>
                      <#list purchaseOrderItemTypeList as orderItemType>
                        <option value="${orderItemType.orderItemTypeId}">${orderItemType.description}</option>
                      </#list>
                    </select>
                  </@td>
                </@tr>
                </#if>
                <@tr>
                  <@td scope="row" class="${styles.grid_large!}3">${uiLabelMap.CommonComment}</@td>
                  <@td>
                      <input type="text" size="25" name="changeComments"/>
                  </@td>
                </@tr>
                <@tr>
                  <@td scope="row" class="${styles.grid_large!}3">&nbsp;</@td>
                  <@td><input type="submit" value="${uiLabelMap.OrderAddToOrder}" class="${styles.link_run_sys!} ${styles.action_add!}"/></@td>
                </@tr>
            </@table>
        </form>
      </@cell>
    </@row>
  </@section>
</#if>