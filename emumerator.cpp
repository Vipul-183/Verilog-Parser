#include <bits/stdc++.h>
#include <fstream>

using namespace std;

int binary_to_int(string s)
{
    int n;
    n = s[0] - '0';
    string s1 = s.substr(3, n);

    int ans = 0;

    for (int i = 0; i < n; i++)
    {
        ans += (s1[i] - '0') * (pow(2, n - i - 1));
    }

    return ans;
}

string converter(string a, string b, string c, int d)
{
    string str, temp;
    if (d == 1)
        temp = "true";
    else
        temp = "change";
    if (c == "or" || c == "||")
    {
        str = "if " + a + " is " + temp + " or " + b + " is " + temp;
    }
    else if (c == "and" || c == "&&")
    {
        str = "if " + a + " is " + temp + " and " + b + " is " + temp;
    }

    return str;
}

void line_to_strings(string s, vector<string> &v)
{

    string cur = "";
    int n = s.size();

    for (int i = 0; i < n; i++)
    {
        if (s[i] == ' ')
        {
            if (cur.size())
                v.push_back(cur), cur = "";
        }
        else
        {
            cur += s[i];
        }
    }

    if (cur.size())
        v.push_back(cur);
}

int main()
{
    fstream file, file2;
    file.open("sample_input_2.v");
    file2.open("output.txt");

    vector<vector<string>> vec(2000);
    string st, curr = "";
    int n = 0, num = 1;

    while (getline(file, st))
    {
        line_to_strings(st, vec[n]);
        n++;
    }

    /*
        for(int i=0;i<n;i++){
            for(int j=0;j<vec[i].size();j++){
                file2<<vec[i][j]<<" ";
            }
            file2<<"\n";
        }
        file2<<"\n\n\n\n\n";
    */

    int flag = 0, flag2 = 0;
    for (int i = 0; i < n; i++)
    {
        // file2<<flag<<" ";
        if (vec[i].size() == 0)
            continue;

        if (vec[i][0] == "assign")
        {
            vec[i][3].pop_back();

            if (curr.size() == 0)
            {
                file2 << "(" << num << ") Assign the value " << vec[i][3] << " to " << vec[i][1] << "\n";
                num++;
            }
            continue;
        }

        if (!flag)
        {
            if (vec[i][0] == "always")
            {
                file2 << "\n(" << num << ") \n";
                num++;

                flag++;
                if (vec[i].size() == 5)
                {
                    if (vec[i][2][0] == '!')
                    {
                        file2 << curr << "if " + vec[i][2].substr(1, vec[i][2].size() - 1) + " is false;, then always block gets executed...\n";
                    }
                    else
                    {
                        file2 << curr << "if " + vec[i][2] + " change, then Always block gets executed...\n";
                    }
                    file2 << "Always block works as follows:\n";
                }
                else
                {
                    file2 << curr << converter(vec[i][2], vec[i][4], vec[i][3], 0) << ", then Always block gets executed...\n";
                    file2 << curr << "Always block works as follows:\n";
                }
                for (int k = 0; k < 4; k++)
                    curr += ' ';
            }
        }
        else
        {
            if (vec[i][0] == "if")
            {
                flag++;
                if (vec[i].size() == 5)
                {
                    if (vec[i][2][0] == '!')
                    {
                        file2 << curr << "if " + vec[i][2].substr(1, vec[i][2].size() - 1) + " is false,\n";
                    }
                    else
                    {
                        file2 << curr << "if " + vec[i][2] + " is true,\n";
                    }
                }
                else
                {
                    file2 << curr << converter(vec[i][2], vec[i][4], vec[i][3], 1) << ",\n";
                }
                for (int k = 0; k < 4; k++)
                    curr += ' ';
            }

            else if (vec[i][0] == "else")
            {
                flag++;

                if (vec[i][1] == "if")
                {
                    file2 << curr << "else ";

                    if (vec[i].size() == 6)
                    {
                        if (vec[i][3][0] == '!')
                        {
                            file2 << vec[i][3].substr(1, vec[i][3].size() - 1) + " is false,\n";
                        }
                        else
                        {
                            file2 << vec[i][3] + " is true,\n";
                        }
                    }
                    else
                    {
                        file2 << converter(vec[i][3], vec[i][5], vec[i][4], 1) << ",\n";
                    }
                    for (int k = 0; k < 4; k++)
                        curr += ' ';
                }
                else
                {
                    file2 << curr << "Otherwise:\n";
                    for (int k = 0; k < 4; k++)
                        curr += ' ';
                }
            }
            else if (vec[i][0] == "end")
            {

                if (flag)
                {
                    for (int k = 0; k < 4; k++)
                        if (curr.size())
                            curr.pop_back();
                    flag--;
                }
                if (flag == 0)
                {
                    file2 << curr << "Always block is completed...\n\n";
                }
            }
            else
            {
                vec[i][0].pop_back();
                file2 << curr << "then, " << vec[i][0] << "\n";
            }
        }
    }

    return 0;
}
