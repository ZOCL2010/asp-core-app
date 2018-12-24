FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY ["asp-core-app2/asp-core-app2.csproj", "asp-core-app2/"]
RUN dotnet restore "asp-core-app2/asp-core-app2.csproj"
COPY . .
WORKDIR "/src/asp-core-app2"
RUN dotnet build "asp-core-app2.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "asp-core-app2.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "asp-core-app2.dll"]