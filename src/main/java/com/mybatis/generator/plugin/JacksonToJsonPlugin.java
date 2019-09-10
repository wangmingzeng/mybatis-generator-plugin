package com.mybatis.generator.plugin;

import java.util.List;

import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.PluginAdapter;
import org.mybatis.generator.api.dom.java.Field;
import org.mybatis.generator.api.dom.java.FullyQualifiedJavaType;
import org.mybatis.generator.api.dom.java.JavaVisibility;
import org.mybatis.generator.api.dom.java.Method;
import org.mybatis.generator.api.dom.java.TopLevelClass;

/**
 * 该plugin是为生成的model类添加toJson方法。toJson方法的实现依赖于FastJson
 *
 * 生成后
 * public class Account implements Serializable { 
 * 	public JSONObject toJson() {
 * 	... ... 
 * } }
 */
public class JacksonToJsonPlugin extends PluginAdapter {

	@Override
	public boolean validate(List<String> warnings) {
		return true;
	}

	@Override
	public boolean modelBaseRecordClassGenerated(TopLevelClass topLevelClass, IntrospectedTable introspectedTable) {
		Method method = new Method();
		method.setName("toJson");
		method.setVisibility(JavaVisibility.PUBLIC);
		method.setReturnType(new FullyQualifiedJavaType("com.alibaba.fastjson.JSONObject"));
		method.addBodyLine("JSONObject answer = new JSONObject();");
		StringBuilder sb = new StringBuilder();
		for (Field field : topLevelClass.getFields()) {
			String property = field.getName();
			if ("serialVersionUID".equals(property)) { // 序列号字段不需要getter和setter方法
				continue;
			}
			sb.setLength(0);
			sb.append("answer.put(\"").append(property).append("\", ").append(property).append(" == null ? \"\":");
			if (field.getType().equals(FullyQualifiedJavaType.getDateInstance())) { // 日期
				sb.append(property).append(".getTime()");
			} else {
				sb.append(property);
			}
			sb.append(");");
			method.addBodyLine(sb.toString());
		}
		method.addBodyLine("return answer;");
		// 增加引入
		topLevelClass.addImportedType(new FullyQualifiedJavaType("com.alibaba.fastjson.JSONObject"));
		// 增加方法
		topLevelClass.addMethod(method);
		return true;
	}

}
