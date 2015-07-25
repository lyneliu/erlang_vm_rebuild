%% Generated by the Erlang ASN.1 compiler version:3.0.4
%% Purpose: Erlang record definitions for each named and unnamed
%% SEQUENCE and SET, and macro definitions for each value
%% definition,in module ELDAPv3



-ifndef(_ELDAPV3_HRL_).
-define(_ELDAPV3_HRL_, true).

-record('LDAPMessage',{
messageID, protocolOp, controls = asn1_NOVALUE}). % with extension mark

-record('AttributeValueAssertion',{
attributeDesc, assertionValue}). % with extension mark

-record('PartialAttribute',{
type, vals}). % with extension mark

-record('LDAPResult',{
resultCode, matchedDN, diagnosticMessage, referral = asn1_NOVALUE}). % with extension mark

-record('Control',{
controlType, criticality = asn1_DEFAULT, controlValue = asn1_NOVALUE}). % with extension mark

-record('BindRequest',{
version, name, authentication}). % with extension mark

-record('SaslCredentials',{
mechanism, credentials = asn1_NOVALUE}). % with extension mark

-record('BindResponse',{
resultCode, matchedDN, diagnosticMessage, referral = asn1_NOVALUE, serverSaslCreds = asn1_NOVALUE}). % with extension mark

-record('SearchRequest',{
baseObject, scope, derefAliases, sizeLimit, timeLimit, typesOnly, filter, attributes}). % with extension mark

-record('SubstringFilter',{
type, substrings}). % with extension mark

-record('MatchingRuleAssertion',{
matchingRule = asn1_NOVALUE, type = asn1_NOVALUE, matchValue, dnAttributes = asn1_DEFAULT}). % with extension mark

-record('SearchResultEntry',{
objectName, attributes}). % with extension mark

-record('ModifyRequest',{
object, changes}). % with extension mark

-record('ModifyRequest_changes_SEQOF',{
operation, modification}). % with extension mark

-record('AddRequest',{
entry, attributes}). % with extension mark

-record('ModifyDNRequest',{
entry, newrdn, deleteoldrdn, newSuperior = asn1_NOVALUE}). % with extension mark

-record('CompareRequest',{
entry, ava}). % with extension mark

-record('ExtendedRequest',{
requestName, requestValue = asn1_NOVALUE}). % with extension mark

-record('ExtendedResponse',{
resultCode, matchedDN, diagnosticMessage, referral = asn1_NOVALUE, responseName = asn1_NOVALUE, responseValue = asn1_NOVALUE}). % with extension mark

-record('IntermediateResponse',{
responseName = asn1_NOVALUE, responseValue = asn1_NOVALUE}). % with extension mark

-define('maxInt', 2147483647).
-endif. %% _ELDAPV3_HRL_
