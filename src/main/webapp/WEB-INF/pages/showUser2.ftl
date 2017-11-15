<#include "/common/listheader.ftl" />
 
  <#if user??>
    ${(user.name)!''}  
  </#if>

<#include "/common/listfooter.ftl" />