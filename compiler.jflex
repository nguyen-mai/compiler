// User code
import java.util.*;
import java.io.*;

%%

// Options and declarations
%class vc
%standalone
%line

digit = [0-9]
number = {digit}+
letter = [a-zA-Z]
identifier = {letter}({letter}|{digit})*
newline = \n
whitespace = [\t ]+
type = ("void"|"boolean"|"int"|"float")
operator = "+" | "-" | "*" | "/" | "<" | "<=" | ">" | ">=" | "==" | "!=" | "&&" | "||" | "!"
array = {identifier}"["{digit}*"]"
separators = "("|")"|"{"|"}"|"."|","|";"
assign = "="
main = "main()"
if = "if"
else = "else"
while = "while"
break = "break"
continue = "continue"
for = "for"
return = "return"

%{
    StringBuffer string = new StringBuffer();
    public static File file = new File("output.txt");

    public static void WriteToFile(String content) {
        try {
            FileWriter myFile = new FileWriter(file, true);
            myFile.write(content + "\n");
            myFile.close();
        } catch (IOException e) {
            WriteToFile("An error occurred.");
            e.printStackTrace();
        }
    }
%}

%%

// Lexical rules
"//".*                                    { /* Do Nothing */ }
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/]       { /* Do Nothing */ }
[/][*]                                    { System.out.println("Unclosed comment");}
{main}	 	{WriteToFile(yytext() + "\t Main function");}
{if} 		{WriteToFile(yytext() + "\t If");}
{else} 		{WriteToFile(yytext() + "\t Else");}
{while} 	{WriteToFile(yytext() + "\t While");}
{break}		{WriteToFile(yytext() + "\t Break");}
{continue}	{WriteToFile(yytext() + "\t Continue");}
{for}		{WriteToFile(yytext() + "\t For");}
{return} 	{WriteToFile(yytext() + "\t Return");}
{assign} 	{WriteToFile(yytext() + "\t Assign");}
{type} 		{WriteToFile(yytext() + "\t Type");}
{number}	{WriteToFile(yytext() + "\t Number");}
{identifier}"(" {WriteToFile(yytext() + "\t Function");}
{operator} 	{WriteToFile(yytext() + "\t Operator");}
{array}		{WriteToFile(yytext() + "\t Array");}
{identifier} 	{WriteToFile(yytext() + "\t Variable");}
{separators}	{WriteToFile(yytext() + "\t Separators");}

{newline} {}
{whitespace} {}
. {WriteToFile(yytext() + " :   Unknown");}
