# Quem São os Clientes de Alto Valor? Segmentação e Retenção

Análise exploratória (EDA) de attrition (cancelamento) e valor de cliente, simulando uma demanda do time de Customer Analytics/Retenção de um banco.

## Contexto

Simulação de uma demanda da Head de Retenção de um banco: entender quem são os clientes de maior valor (relacionamento, gasto, tempo de casa) e quais sinais aparecem antes de um cliente encerrar o relacionamento com o banco.

## Problema de negócio

O time de Retenção não tinha uma visão clara de quais características diferenciam clientes que cancelam (`Attrited Customer`) dos que permanecem, o que dificultava agir preventivamente.

## Objetivo

Segmentar os clientes por valor combinando gasto e relacionamento, e comparar o perfil de clientes attrited vs. existing para identificar sinais associados à saída.

## Dataset

- **Nome:** Credit Card Customers
- **Fonte:** [Kaggle — sakshigoyal7](https://www.kaggle.com/datasets/sakshigoyal7/credit-card-customers)
- **Registros:** 10.127 clientes, arquivo `BankChurners.csv` (mesmo dataset do Projeto 2, agora explorando `Attrition_Flag`, `Total_Relationship_Count`, `Months_Inactive_12_mon` e `Contacts_Count_12_mon`)

## Ferramentas

- SQL (MySQL) para exploração e métricas agregadas
- Python (pandas, seaborn, matplotlib) para segmentação e EDA
- Jupyter Notebook

## Metodologia

1. Exploração via SQL: taxa geral de attrition e por categoria de cartão, comparação de médias entre grupos.
2. Em Python: criação de uma métrica composta de valor de cliente (`valor_cliente = Total_Trans_Amt × Total_Relationship_Count`) e comparação visual entre grupos.
3. Cruzamento de baixo relacionamento (poucos produtos) com attrition.

## Principais análises

- Taxa geral de attrition
- Comparação de relacionamento, inatividade e contatos entre clientes attrited e existing
- Taxa de attrition por categoria de cartão
- Top clientes por valor combinado (gasto × nº de produtos)
- Relação entre poucos produtos e attrition

## Principais insights

- A taxa geral de attrition é de **16,07%** (1 em cada ~6 clientes cancelou o relacionamento).
- Clientes attrited têm, em média, **menos produtos** com o banco (3,28 vs. 3,91 de `Total_Relationship_Count`) — menos vínculo, menor custo de troca.
- Clientes attrited têm, em média, **mais meses inativos** (2,69 vs. 2,27) e, ao mesmo tempo, **mais contatos com o banco** nos últimos 12 meses (2,97 vs. 2,36) — um padrão que sugere tentativas de suporte/reclamação antes do cancelamento, não simples desengajamento silencioso.
- **579 clientes** têm baixo relacionamento (≤ 2 produtos) e já cancelaram — reforça que poucos produtos é um dos sinais mais fortes associados à saída.
- A métrica de valor combinado (`valor_cliente`) evita priorizar apenas quem gasta muito, destacando também quem tem múltiplos produtos ativos — um retrato mais completo do vínculo do cliente com o banco do que olhar só para o gasto.

## Recomendações

- Priorizar ações de cross-sell (aumentar `Total_Relationship_Count`) como estratégia de retenção, já que baixo relacionamento é o sinal mais associado à saída.
- Investigar os motivos de contato dos clientes com aumento de `Contacts_Count_12_mon` antes de cancelarem — pode ser um alerta antecipado utilizável em um modelo de propensão a churn.
- Usar a métrica de valor combinado (gasto × produtos), em vez de gasto isolado, para priorizar clientes em campanhas de retenção.

## Limitações

- Dataset de clientes dos EUA; valores absolutos não refletem o mercado brasileiro.
- `Attrition_Flag` é um retrato histórico — não indica o momento exato em que o cliente decidiu sair.
- A métrica `valor_cliente` é uma combinação simples (multiplicação); em um cenário real valeria testar pesos diferentes ou normalização entre as variáveis.

## Conclusão

A análise aponta o número de produtos ativos como o sinal mais consistente associado ao cancelamento, e sugere que picos de contato com o banco podem funcionar como alerta antecipado. Esses achados dão insumo direto para priorização de ações de retenção.

## Como executar

```bash
pip install pandas seaborn matplotlib
```

1. Baixe o `BankChurners.csv` a partir do link do Kaggle acima (não incluído neste repositório).
2. Rode os scripts SQL em `sql/` em um banco MySQL.
3. Abra o notebook em `python/` no Jupyter.
