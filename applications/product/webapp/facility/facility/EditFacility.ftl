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

<#if facility?? && facilityId?has_content>
  <form action="<@ofbizUrl>UpdateFacility</@ofbizUrl>" name="EditFacilityForm" method="post" class="basic-form">
  <input type="hidden" name="facilityId" value="${facilityId!}" />
<#else>
  <form action="<@ofbizUrl>CreateFacility</@ofbizUrl>" name="EditFacilityForm" method="post" class="basic-form">
  <#if facilityId??>
    <@alert type="error">${uiLabelMap.ProductCouldNotFindFacilityWithId} "${facilityId!}".</@alert>
  </#if>
</#if>

<#if facility?? && facilityId?has_content>
  <@field type="generic" label="${uiLabelMap.ProductFacilityId}" tooltip="${uiLabelMap.ProductNotModificationRecrationFacility}">
      ${facilityId!}
  </@field>
</#if>

  <@field type="generic" label="${uiLabelMap.ProductFacilityTypeId}">
      <select name="facilityTypeId">
        <option selected="selected" value="${facilityType.facilityTypeId!}">${facilityType.get("description",locale)!}</option>
        <option value="${facilityType.facilityTypeId!}">----</option>
        <#list facilityTypes as nextFacilityType>
          <option value="${nextFacilityType.facilityTypeId!}">${nextFacilityType.get("description",locale)!}</option>
        </#list>
      </select>
  </@field>
  <@field type="generic" label="${uiLabelMap.FormFieldTitle_parentFacilityId}">
      <@htmlTemplate.lookupField value="${facility.parentFacilityId!}" formName="EditFacilityForm" name="parentFacilityId" id="parentFacilityId" fieldFormName="LookupFacility"/>
  </@field>
  <@field type="generic" label="${uiLabelMap.ProductFacilityOwner}" required=true>
      <@htmlTemplate.lookupField value="${facility.ownerPartyId!}" formName="EditFacilityForm" name="ownerPartyId" id="ownerPartyId" fieldFormName="LookupPartyName"/>
  </@field>
  <@field type="generic" label="${uiLabelMap.ProductFacilityDefaultWeightUnit}">
      <select name="defaultWeightUomId">
          <option value="">${uiLabelMap.CommonNone}</option>
          <#list weightUomList as uom>
            <option value="${uom.uomId}"
               <#if (facility.defaultWeightUomId?has_content) && (uom.uomId == facility.defaultWeightUomId)>
               selected="selected"
               </#if>
             >${uom.get("description",locale)?default(uom.uomId)}</option>
          </#list>
      </select>
  </@field>
  <@field type="generic" label="${uiLabelMap.ProductFacilityDefaultInventoryItemType}">
      <select name="defaultInventoryItemTypeId">
          <#list inventoryItemTypes as nextInventoryItemType>
            <option value="${nextInventoryItemType.inventoryItemTypeId}"
               <#if (facility.defaultInventoryItemTypeId?has_content) && (nextInventoryItemType.inventoryItemTypeId == facility.defaultInventoryItemTypeId)>
               selected="selected"
               </#if>
             >${nextInventoryItemType.get("description",locale)?default(nextInventoryItemType.inventoryItemTypeId)}</option>
          </#list>
      </select>
  </@field>
  <@field type="generic" label="${uiLabelMap.ProductName}" required=true>
      <input type="text" name="facilityName" value="${facility.facilityName!}" size="30" maxlength="60" />
  </@field>
  <@field type="generic" label="${uiLabelMap.ProductFacilitySize}">
      <input type="text" name="facilitySize" value="${facility.facilitySize!}" size="10" maxlength="20" />
  </@field>
  <@field type="generic" label="${uiLabelMap.ProductFacilityDefaultAreaUnit}">
      <select name="facilitySizeUomId">
          <option value="">${uiLabelMap.CommonNone}</option>
          <#list areaUomList as uom>
            <option value="${uom.uomId}"
               <#if (facility.facilitySizeUomId?has_content) && (uom.uomId == facility.facilitySizeUomId)>
               selected="selected"
               </#if>
             >${uom.get("description",locale)?default(uom.uomId)}</option>
          </#list>
      </select>
  </@field>  
  <@field type="generic" label="${uiLabelMap.ProductProductDescription}">
      <input type="text" name="description" value="${facility.description!}" size="60" maxlength="250" />
  </@field>
  <@field type="generic" label="${uiLabelMap.ProductDefaultDaysToShip}">
      <input type="text" name="defaultDaysToShip" value="${facility.defaultDaysToShip!}" size="10" maxlength="20" />
  </@field>

  <@field type="submitarea">
    <#if facilityId?has_content>
      <input type="submit" name="Update" value="${uiLabelMap.CommonUpdate}" class="${styles.link_run_sys!} ${styles.action_update!}" />
    <#else>
      <input type="submit" name="Update" value="${uiLabelMap.CommonSave}" class="${styles.link_run_sys!} ${styles.action_add!}" />
    </#if>
  </@field>

</form>
