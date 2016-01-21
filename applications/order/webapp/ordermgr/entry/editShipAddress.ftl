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

<#if security.hasEntityPermission("ORDERMGR", "_CREATE", session) || security.hasEntityPermission("ORDERMGR", "_PURCHASE_CREATE", session)>

  <@section>
    <#if postalAddress?has_content>
      <form method="post" action="<@ofbizUrl>updatePostalAddressOrderEntry</@ofbizUrl>" name="checkoutsetupform">
        <input type="hidden" name="contactMechId" value="${shipContactMechId!}"/>
    <#else>
      <form method="post" action="<@ofbizUrl>createPostalAddress</@ofbizUrl>" name="checkoutsetupform">
        <input type="hidden" name="contactMechTypeId" value="POSTAL_ADDRESS"/>
        <input type="hidden" name="contactMechPurposeTypeId" value="SHIPPING_LOCATION"/>
    </#if>
        <input type="hidden" name="partyId" value="${cart.getPartyId()?default("_NA_")}"/>
        <input type="hidden" name="finalizeMode" value="ship"/>
        <#if orderPerson?? && orderPerson?has_content>
          <#assign toName = "">
          <#if orderPerson.personalTitle?has_content><#assign toName = orderPerson.personalTitle + " "></#if>
          <#assign toName = toName + orderPerson.firstName + " ">
          <#if orderPerson.middleName?has_content><#assign toName = toName + orderPerson.middleName + " "></#if>
          <#assign toName = toName + orderPerson.lastName>
          <#if orderPerson.suffix?has_content><#assign toName = toName + " " + orderPerson.suffix></#if>
        <#elseif parameters.toName??>
          <#assign toName = parameters.toName>
        <#else>
          <#assign toName = "">
        </#if>
        <@field type="generic" label="${uiLabelMap.CommonToName}">
            <input type="text" size="30" maxlength="60" name="toName" value="${toName}"/>
        </@field>
        <@field type="generic" label="${uiLabelMap.CommonAttentionName}">
            <input type="text" size="30" maxlength="60" name="attnName" value="${parameters.attnName!}"/>
        </@field>
        <@field type="generic" label="${uiLabelMap.CommonAddressLine} 1" required=true>
            <input type="text" size="30" maxlength="30" name="address1" value="${parameters.address1!}"/>
        </@field>
        <@field type="generic" label="${uiLabelMap.CommonAddressLine} 2">
            <input type="text" size="30" maxlength="30" name="address2" value="${parameters.address2!}"/>
        </@field>
        <@field type="generic" label="${uiLabelMap.CommonCity}" required=true>
            <input type="text" size="30" maxlength="30" name="city" value="${parameters.city!}"/>
        </@field>
        <@field type="generic" label="${uiLabelMap.CommonStateProvince}">
            <select name="stateProvinceGeoId">
              <option value=""></option>
              ${screens.render("component://common/widget/CommonScreens.xml#states")}
            </select>
        </@field>
        <@field type="generic" label="${uiLabelMap.CommonZipPostalCode}" required=true>
            <input type="text" size="12" maxlength="10" name="postalCode" value="${parameters.postalCode!}"/>
        </@field>
        <@field type="generic" label="${uiLabelMap.CommonCountry}" required=true>
            <select name="countryGeoId">
              ${screens.render("component://common/widget/CommonScreens.xml#countries")}
            </select>
        </@field>
        <@field type="generic" label="${uiLabelMap.OrderAllowSolicitation}">
            <select name="allowSolicitation">
              <#assign selectedValue = parameters.allowSolicitation?default("")/>
              <option></option><option${(selectedValue=="Y")?string(" selected=\"selected\"","")}>Y</option><option${(selectedValue=="N")?string(" selected=\"selected\"","")}>N</option>
            </select>
        </@field>
      </form>
  </@section>
<#else>
  <@alert type="error">${uiLabelMap.OrderViewPermissionError}</@alert>
</#if>
